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
      request_url = if url[0] == '/'
                      options[:headers].merge!('Authorization' => "Bearer #{Vimeo.token}")
                      "#{BASE_API_URI}#{url}"
                    else
                      url
                    end

      response = HTTParty.send(method, request_url, options)
      if response.success? || response.code.to_i == 308
        parse_success response
      else
        parse_failed response
      end
    end

    def get(url, options = {}, headers = {})
      request(url, query: options, headers: headers)
    end

    def post(url, options = {}, headers = {})
      request(url, { body: options, headers: headers }, :post)
    end

    def delete(url, options = {}, headers = {})
      request(url, { body: options, headers: headers }, :delete)
    end

    def put(url, options = {}, headers = {})
      request(url, { body: options, headers: headers }, :put)
    end

    def patch(url, options = {}, headers = {})
      request(url, { body: options, headers: headers }, :patch)
    end

    private

    def parse_success(response)
      result = response_exists?(response) ? response.body : '{}'
      response_hash = JSON.parse(result)
      response_hash[:headers] = response.headers
      ::Hashie::Mash.new(response_hash)
    end

    def parse_failed(response)
      error = (ERROR_CODES[response.code] || UnknownError).new(response)
      raise error, error.message
    end

    def response_exists?(response)
      response.body && !response.body.empty?
    end

  end
end

