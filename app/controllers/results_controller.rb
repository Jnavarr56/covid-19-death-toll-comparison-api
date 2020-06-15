require "scrape_cdc_html"
require "parse_nyt_csv"
require "fetch_john_hopkins_json"
require "calculate_cache_exp_secs"

class ResultsController < ApplicationController
    def get_results
        results_data = init_response("results")
        render :json => results_data
    end

    def get_sources
        results_data = init_response("sources")
        render :json => results_data
    end

    private 

    def init_response(data_key)
        cached = Rails.cache.read(data_key)
        if cached == nil
            execute
            cached = Rails.cache.read(data_key)
        end

        cached
    end

    def execute
        
        cdc_data = scrape_cdc_html
        nyt_data = parse_nyt_csv
        jhu_data = fetch_john_hopkins_json
        
        cache_exp_secs = calculate_cache_exp_secs

        

        output = { 
            "results" => {
                "cdc" => {
                    "death_count" => cdc_data["death_count"]
                },
                "nyt" => {
                    "death_count" => nyt_data["death_count"]
                },
                "jhu" => {
                    "death_count" => jhu_data["death_count"]
                }
            },
            "sources" => {
                "cdc" => cdc_data["source_info"],
                "nyt" => nyt_data["source_info"],
                "jhu" => jhu_data["source_info"]
            }
        }

        Rails.cache.write("results", output["results"], :expires_in => cache_exp_secs)
        Rails.cache.write("sources", output["sources"], :expires_in => cache_exp_secs)

        output
    end

end