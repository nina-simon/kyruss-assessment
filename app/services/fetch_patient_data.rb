require 'net/http'
require 'json'

class FetchPatientData
  API_URL = "https://dummyjson.com/users/".freeze

  def initialize(patient_id)
    @patient_id = patient_id
  end

  def call
    uri = URI("#{API_URL}#{@patient_id}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error("Failed to fetch patient data: #{e.message}")
    nil
  end
end
