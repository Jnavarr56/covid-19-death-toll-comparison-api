require 'net/http'
require 'json'
require 'csv'

JHU_JSON_URL = 'https://api.covid19api.com/summary'

def fetch_john_hopkins_json
    request_uri = URI(JHU_JSON_URL)
    request_response = Net::HTTP.get_response(request_uri)
    response_json = JSON.parse(request_response.body)

    countries = response_json["Countries"]
    
    us_data = countries.find { |country_data| 
        country_data["CountryCode"] == "US"
    } 

    

    {
        "death_count" => us_data["TotalDeaths"],
        "source_info" => {
            "data_type" => "JSON",
            "data_link" => JHU_JSON_URL,
            "org_link" => "https://covid19api.com/",
            "description" => "
                A free API for data on the Coronavirus
                Access data on COVID19 through an easy API for free. Build dashboards, mobile apps or integrate in to other applications. Data is sourced from Johns Hopkins CSSE

                Built by Kyle Redelinghuys
            "
        }
    }
    
end