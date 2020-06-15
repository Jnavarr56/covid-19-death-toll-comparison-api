def calculate_cache_exp_secs        
        current_hour = DateTime.now.hour

        if current_hour < 22
            hours_until_next_fetch = (current_hour < 13 ? 13 - current_hour : 22 - current_hour).hours
            next_fetch_datetime = (DateTime.now + hours_until_next_fetch).beginning_of_hour
        else
            next_fetch_datetime = (DateTime.now + 1.days).beginning_of_day + 13.hours
        end 


        ((next_fetch_datetime - DateTime.now)* 24 * 60 * 60).to_i
end