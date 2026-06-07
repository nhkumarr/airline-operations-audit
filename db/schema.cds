namespace airline.operations;

entity MarketingFlights {
  key ID                         : UUID;
      FlightDate                 : Date;
      Year                       : Integer;
      Month                      : Integer;
      Marketing_Airline_Network  : String(10);
      Flight_Number_Marketing    : String(20);
      Origin                     : String(10);
      OriginCityName             : String(100);
      Dest                       : String(10);
      DestCityName               : String(100);
      DepDelay                   : Decimal(9,2);
      ArrDelay                   : Decimal(9,2);
      Cancelled                  : Boolean;
}

entity ReportingFlights {
  key ID                         : UUID;
      FlightDate                 : Date;
      Year                       : Integer;
      Month                      : Integer;
      Reporting_Airline          : String(10);
      Tail_Number                : String(20);
      Flight_Number_Reporting    : String(20);
      Origin                     : String(10);
      Dest                       : String(10);
      CarrierDelay               : Decimal(9,2);
      WeatherDelay               : Decimal(9,2);
      NASDelay                   : Decimal(9,2);
      SecurityDelay              : Decimal(9,2);
      LateAircraftDelay          : Decimal(9,2);
      DepDelay                   : Decimal(9,2);
      ArrDelay                   : Decimal(9,2);
      Cancelled                  : Boolean;
}

entity FlightClassifications {
  key ID                         : UUID;
      FlightDate                 : Date;
      Airline                    : String(10);
      Origin                     : String(10);
      Dest                       : String(10);
      ArrDelay                   : Decimal(9,2);
      DelayCategory              : String(30);
      ReliabilityTier            : String(30);
}