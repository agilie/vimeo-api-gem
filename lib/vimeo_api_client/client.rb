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
      500 => InternalServerError,
      502 => BadGateway,
      503 => ServiceUnavailable,
      504 => GatewayTimeout
    }.freeze

    def request(url, options = {}, method = :get)
      options.merge!({headers: {
        'Authorization' => "Bearer #{Vimeo.token}"
      }})

      request_url = url[0] == '/' ? "#{BASE_API_URI}#{url}" : url

      response = HTTParty.send(method, request_url, options)
      if response.success?
        parse_success response
      else
        parse_failed response
      end
    end

    private

    def parse_success(response)
      return unless response.body
      response_hash = JSON.parse(response.body)
      ::Hashie::Mash.new(response_hash)
    end

    def parse_failed(response)
      error = ERROR_CODES[response.code].new(response)
      raise error, error.message
    end

  end
end

