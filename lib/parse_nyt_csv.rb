require 'net/http'
require 'csv'

NYT_CSV_URL = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/live/us.csv'

def parse_nyt_csv
    request_uri = URI(NYT_CSV_URL)
    request_response = Net::HTTP.get_response(request_uri)

    csv_string = request_response.body
    csv_rows = CSV.parse(csv_string)

    header_row = csv_rows.first
    data_row = csv_rows.last

    death_count_col = header_row.index('deaths')
    
    {
        "death_count" => data_row[death_count_col].to_i,
        "source_info" => {
            "data_type" => "CSV",
            "data_link" => NYT_CSV_URL,
            "org_link" => "https://github.com/nytimes/covid-19-data",
            "description" => "
                The New York Times is releasing a series of data files with cumulative counts of coronavirus cases in the United States, at the state and county level, over time. We are compiling this time series data from state and local governments and health departments in an attempt to provide a complete record of the ongoing outbreak.

                Since late January, The Times has tracked cases of coronavirus in real time as they were identified after testing. Because of the widespread shortage of testing, however, the data is necessarily limited in the picture it presents of the outbreak.
            "
        }
    }
     
end