require 'httparty'
require 'hashie'

require 'vimeo_api_client/exceptions'

module Vimeo
  module Client

    include HTTParty

    BASE_API_URI = 'https://api.vimeo.com'.freeze

    ERROR_CODES = {
      400 => BadRequest,
      401 => Unauthorized,
      403 => NotAllowed,
      404 => NotFound,
      429 => TooManyRequests,
      500 => InternalServerError,
      502 => BadGateway,
      503 => ServiceUnavailable,
      504 => GatewayTimeout
    }.freeze

    def request(url, options = {}, method = :get)
      options.merge!({ headers: {
        'Authorization' => "Bearer #{Vimeo.token}"
      } })

      request_url = url[0] == '/' ? "#{BASE_API_URI}#{url}" : url

      response = HTTParty.send(method, request_url, options)
      if response.success?
        parse_success response
      else
        parse_failed response
      end
    end

    def get(url, options = {})
      request(url, options)
    end

    def post(url, options = {})
      request(url, { body: options }, :post)
    end

    def delete(url, options = {})
      request(url, { body: options }, :delete)
    end

    def put(url, options = {})
      request(url, { body: options }, :put)
    end

    def patch(url, options = {})
      request(url, { body: options }, :patch)
    end

    private

    def parse_success(response)
      result = response_exists?(response) ? response.body : '{}'
      response_hash = JSON.parse(result)
      response_hash[:headers] = response.headers
      ::Hashie::Mash.new(response_hash)
    end

    def parse_failed(response)
      error = ERROR_CODES[response.code].new(response)
      raise error, error.message
    end

    def response_exists?(response)
      response.body && !response.body.empty?
    end

  end
end

