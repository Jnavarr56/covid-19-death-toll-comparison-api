# README

The production (master) branch requires PRODUCTION_HOST and PRODUCTION_CLIENT_ORIGIN env vars in order to allow requests to the deployment host domain and whitelist CORS requests from the front end app which can be found at this repo https://github.com/Jnavarr56/covid-19-death-toll-comparison-ui and deployed here http://coviddeathtollcomparison.com/.

To just play around with this, check into the development branch (dev) and:

1. make sure docker is running (ex: `sudo service docker start`)
2. give execution permissions for run.sh file if necessary (ex: `chmod +x ./run.sh`)
3. start up containers `docker-compose up`

All CORS allowed in development.

### Caching

Data is fetched and cached until hr 13 of the day. After, it is fetched and cached again until hr 22 of the day. Tried to have it link up with 9am and 6pm eastern time. Uses Redis.

```
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
```

### Endpoints

/results
/sources
