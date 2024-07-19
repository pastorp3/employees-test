# app/services/api_client_service.rb
require "uri"
require "net/http"
require "json"

class ApiClientService
  BASE_URL = "https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment"
  TOKEN_ENDPOINT = '/token'
  EMPLOYEES_ENDPOINT = '/employee/list'

  def fetch_access_token
    response = make_post_request(TOKEN_ENDPOINT, token_request_body)
    JSON.parse(response.body)['access_token']
  end

  def fetch_employees
    token = fetch_access_token
    response = make_get_request(EMPLOYEES_ENDPOINT, token)
    JSON.parse(response.body)
  end

  private

  def make_post_request(endpoint, body)
    uri = URI(BASE_URL + endpoint)
    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = JSON.dump(body)
    make_request(uri, request)
  end

  def make_get_request(endpoint, token)
    uri = URI(BASE_URL + endpoint)
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{token}"
    make_request(uri, request)
  end

  def make_request(uri, request)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    response = https.request(request)
    raise "HTTP Request failed: #{response.code} #{response.message}" unless response.is_a?(Net::HTTPSuccess)
    response
  end

  def token_request_body
    {
      grant_type: 'password',
      client_id: '6779ef20e75817b79605',
      client_secret: '3e0f85f44b9ffbc87e90acf40d482602',
      username: 'hiring',
      password: 'tmtg'
    }
  end
end
