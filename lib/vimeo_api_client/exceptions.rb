module Vimeo

  class Error < StandardError
    attr_reader :message, :code

    def initialize(response)
      body = JSON.parse(response.body)

      @code = "#{response.code}"
      @message = body['error']
    end
  end

  # Raised when Vimeo returns the HTTP status code 400
  class BadRequest < Error
  end

  # Raised when Vimeo returns the HTTP status code 401
  class Unauthorized < Error
  end

  # Raised when Vimeo returns the HTTP status code 403
  class NotAllowed < Error
  end

  # Raised when Vimeo returns the HTTP status code 404
  class NotFound < Error
  end

  # Raised when Vimeo returns the HTTP status code 429
  class TooManyRequests < Error
  end

  # Raised when Vimeo returns the HTTP status code 500
  class InternalServerError < Error
  end

  # Raised when Vimeo returns the HTTP status code 502
  class BadGateway < Error
  end

  # Raised when Vimeo returns the HTTP status code 503
  class ServiceUnavailable < Error
  end

  # Raised when Vimeo returns the HTTP status code 504
  class GatewayTimeout < Error
  end

end