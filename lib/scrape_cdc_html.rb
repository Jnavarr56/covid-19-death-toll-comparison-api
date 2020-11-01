# frozen_string_literal: true

require 'nokogiri'
require 'net/http'
require 'net/https'

CDC_HTML_URL = ENV['SCRAPE_URL']
FRIENDLY_LINK = 'https://www.cdc.gov/coronavirus/2019-ncov/cases-updates/cases-in-us.html'

def scrape_cdc_html
  request_uri = URI(CDC_HTML_URL)
  http = Net::HTTP.new(request_uri.host, request_uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Get.new(request_uri)
  request_response = http.request(request)
  html_string = request_response.body
  html_data = Nokogiri::HTML.parse(html_string)
  death_count_el = html_data.at_css('#viz002_usdeaths > div:first-child .card-number')
  death_count = death_count_el.inner_html.to_s.gsub(',', '').to_i

  {
    'death_count' => death_count,
    'source_info' => {
      'data_type' => 'HTML',
      'data_link' => FRIENDLY_LINK,
      'org_link' => FRIENDLY_LINK,
      'description' => "
                        Data on this page are reported voluntarily to CDC by each jurisdiction’s health department. CDC encourages all jurisdictions to report the most complete and accurate information that best represents the current status of the pandemic in their jurisdiction.
                    "
    }
  }
end
