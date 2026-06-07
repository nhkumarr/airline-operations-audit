using airline.operations as db from '../db/schema';

service AirlineService {
  entity MarketingFlights as projection on db.MarketingFlights;
  entity ReportingFlights as projection on db.ReportingFlights;
  entity FlightClassifications as projection on db.FlightClassifications;
}