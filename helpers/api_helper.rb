# I use API token to do authentication. I need to combine my email address and API token to generate the authorization header.
# The email address and API token combination need to be a Base-64 encoded string. So I need to write an encode function and call it to make this string.  
# More information is available here: https://support.zendesk.com/hc/en-us/articles/115000510267-How-can-I-authenticate-API-requests-

require 'httparty'
require_relative '../config/configuration.rb'

class ApiHelper
  # helper function to assist authentication when making request to api
  def self.make_req_to_api(url)
    full_token = Configuration.encode_token # call the encode function

    # include the header when making request
    res = HTTParty.get(url, headers: { "Authorization" => "Basic #{full_token}" })
  end
  
end