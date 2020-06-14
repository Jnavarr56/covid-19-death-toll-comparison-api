require "calculate_results"

class ResultsController < ApplicationController
    def index

        cached_results = Rails.cache.read("results")        
        

        if cached_results == nil
            puts "from calculation"
            results = calculate_results()

            current_hour = DateTime.now.hour

            if current_hour < 22
                hours_until_next_fetch = (current_hour < 13 ? 13 - current_hour : 22 - current_hour).hours
                next_fetch_datetime = (DateTime.now + hours_until_next_fetch).beginning_of_hour
            else
                next_fetch_datetime = (DateTime.now + 1.days).beginning_of_day + 13.hours
            end 


            cache_exp_secs = ((next_fetch_datetime - DateTime.now)* 24 * 60 * 60).to_i
            puts cache_exp_secs

            Rails.cache.write("results", results, expires_in: cache_exp_secs)
    
            render :json => results
        
            
        else
            puts "from cache"
            render :json => cached_results
        end

        
    end
end