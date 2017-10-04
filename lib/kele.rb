require 'httparty'
require 'json'
require './lib/roadmap.rb'

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    response = self.class.post(bloc_api_url("sessions"), body: {"email": email, "password": password} )
    #puts response.code
    #puts response
    body = JSON.parse(response.body)
    raise "Error: #{body['message']}" if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(bloc_api_url("users/me"), headers: {"authorization" => @auth_token})
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(bloc_api_url("mentors/#{mentor_id}/student_availability"), headers: { "authorization" => @auth_token })
    @mentor_availability = JSON.parse(response.body)
  end

  private

  def bloc_api_url(end_point)
    "https://www.bloc.io/api/v1/#{end_point}"
  end
  #base_uri method in httparty

end
