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

}