using airline.operations as db from '../db/schema';

service AirlineService {

  entity MarketingFlights as projection on db.MarketingFlights;
  entity ReportingFlights as projection on db.ReportingFlights;
  entity FlightClassifications as projection on db.FlightClassifications;

  entity ClassifiedReportingFlights as select from db.ReportingFlights {
    key ID,
        FlightDate,
        Year,
        Month,
        Reporting_Airline,
        Tail_Number,
        Flight_Number_Reporting,
        Origin,
        Dest,
        DepDelay,
        ArrDelay,
        Cancelled,

        case
          when ArrDelay <= 15 then 'On-Time'
          when ArrDelay > 15 and ArrDelay <= 30 then 'Minor Delay'
          when ArrDelay > 30 and ArrDelay <= 60 then 'Moderate Delay'
          when ArrDelay > 60 and ArrDelay <= 120 then 'Major Delay'
          else 'Critical Delay'
        end as DelayCategory : String(30)
  };
  entity ReportingAirlinePerformance as select from db.ReportingFlights {
    Reporting_Airline,
    count(*) as TotalFlights : Integer,
    avg(ArrDelay) as AvgArrivalDelay : Decimal(9,2),
    avg(DepDelay) as AvgDepartureDelay : Decimal(9,2),
    sum(case when Cancelled = true then 1 else 0 end) as CancelledFlights : Integer,
    sum(case when ArrDelay <= 15 then 1 else 0 end) as OnTimeFlights : Integer
  }
  group by Reporting_Airline;
}