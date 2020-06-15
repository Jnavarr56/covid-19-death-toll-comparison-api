require 'nokogiri'
require 'net/http'

CDC_HTML_URL = 'https://www.cdc.gov/coronavirus/2019-ncov/cases-updates/cases-in-us.html'

def scrape_cdc_html
    request_uri = URI(CDC_HTML_URL)
    request_response = Net::HTTP.get_response(request_uri)

    html_string = request_response.body
    html_data = Nokogiri::HTML.parse(html_string)

    html_data.css('.count').each do |element|
        label = element.previous_sibling.to_s
        if (label =~ /Total Deaths/) != nil
            return {
                "death_count" => element.inner_html.tr('^0-9', '').to_i,
                "source_info" => {
                    "data_type" => "HTML",
                    "data_link" => CDC_HTML_URL,
                    "org_link" => CDC_HTML_URL,
                    "description" => "
                        Data on this page are reported voluntarily to CDC by each jurisdiction’s health department. CDC encourages all jurisdictions to report the most complete and accurate information that best represents the current status of the pandemic in their jurisdiction.
                    "
                }
            }
        end
    end    

end