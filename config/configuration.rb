# function to encode email address and API token combination to be a Base-64 encoded string, which the header needs it 

class Configuration
  def self.encode_token
    email_address = "allen0lee@gmail.com"
    token = "bhSIXtaecGvqTHiJfx63dUNJxzbuXeBRr5ZfAXcy"
    full_token = Base64.strict_encode64("#{email_address}/token:#{token}")
  end
end