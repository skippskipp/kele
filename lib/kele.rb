require 'httparty'

class Kele
  include HTTParty
  def initialize(email, password)
    response = self.class.post(bloc_api_url("sessions"), body: {"email": email, "password": password} )
    #puts response.code
    #puts response
    body = JSON.parse(response.body)
    raise "Error: #{body['message']}" if response.code != 200
    @auth_token = response["auth_token"]
  end

  private

  def bloc_api_url(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
  #base_uri method in httparty

end
