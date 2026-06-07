import csv
import uuid

def clean_line(line):
    line = line.strip()
    if line.startswith('"') and line.endswith('"'):
        line = line[1:-1]
    return line.replace('""', '"')

def convert(input_file, output_file, output_fields, field_map):
    with open(input_file, "r", encoding="utf-8-sig") as f:
        lines = [clean_line(line) for line in f.readlines() if line.strip()]

    reader = csv.DictReader(lines)

    with open(output_file, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=output_fields)
        writer.writeheader()

        for row in reader:
            new_row = {"ID": str(uuid.uuid4())}

            for out_field, in_field in field_map.items():
                value = row.get(in_field, "")

                if out_field == "Cancelled":
                    value = "true" if value in ["1", "1.00"] else "false"

                new_row[out_field] = value

            writer.writerow(new_row)

marketing_fields = [
    "ID", "FlightDate", "Year", "Month", "Marketing_Airline_Network",
    "Flight_Number_Marketing", "Origin", "OriginCityName", "Dest",
    "DestCityName", "DepDelay", "ArrDelay", "Cancelled"
]

reporting_fields = [
    "ID", "FlightDate", "Year", "Month", "Reporting_Airline",
    "Tail_Number", "Flight_Number_Reporting", "Origin", "Dest",
    "CarrierDelay", "WeatherDelay", "NASDelay", "SecurityDelay",
    "LateAircraftDelay", "DepDelay", "ArrDelay", "Cancelled"
]

convert(
    "db/data/airline.operations-MarketingFlights.csv",
    "db/data/clean_marketing.csv",
    marketing_fields,
    {
        "FlightDate": "FlightDate",
        "Year": "Year",
        "Month": "Month",
        "Marketing_Airline_Network": "Marketing_Airline_Network",
        "Flight_Number_Marketing": "Flight_Number_Marketing_Airline",
        "Origin": "Origin",
        "OriginCityName": "OriginCityName",
        "Dest": "Dest",
        "DestCityName": "DestCityName",
        "DepDelay": "DepDelay",
        "ArrDelay": "ArrDelay",
        "Cancelled": "Cancelled",
    },
)

convert(
    "db/data/airline.operations-ReportingFlights.csv",
    "db/data/clean_reporting.csv",
    reporting_fields,
    {
        "FlightDate": "FlightDate",
        "Year": "Year",
        "Month": "Month",
        "Reporting_Airline": "Reporting_Airline",
        "Tail_Number": "Tail_Number",
        "Flight_Number_Reporting": "Flight_Number_Reporting_Airline",
        "Origin": "Origin",
        "Dest": "Dest",
        "CarrierDelay": "CarrierDelay",
        "WeatherDelay": "WeatherDelay",
        "NASDelay": "NASDelay",
        "SecurityDelay": "SecurityDelay",
        "LateAircraftDelay": "LateAircraftDelay",
        "DepDelay": "DepDelay",
        "ArrDelay": "ArrDelay",
        "Cancelled": "Cancelled",
    },
)

print("Clean CSV files created successfully.")