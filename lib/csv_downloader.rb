require 'net/http'
require 'csv'

class CSVDownloader
    attr_reader :response_data, :file, :csv_rows
    attr_accessor :dataset_url, :filename

    @dataset_url = nil
    @response_data = nil
    @filename = nil
    @csv_rows = nil

    def initialize(dataset_url)
        @dataset_url = dataset_url
    end

    def download(filename)
        request_data
        write_data_to_csv_rows(filename)
    end

    private

    def request_data
        dataset_request_uri = URI(@dataset_url)
        dataset_request_response = Net::HTTP.get_response(dataset_request_uri)

        dataset_request_status_code = dataset_request_response.code.to_i

        if dataset_request_status_code != 200
            puts "ERROR FETCHING DATASET: #{ dataset_request_status_code.code }"
        else
            @response_data = dataset_request_response.body
        end
    end

    def write_data_to_csv_rows(filename)
        @csv_rows = CSV.parse(@response_data)
        @csv_rows        
    end
end