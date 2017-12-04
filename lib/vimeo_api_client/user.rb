require 'vimeo_api_client/client'

module Vimeo
  class User

    include Client

    attr_reader :id

    def initialize(id = nil)
      @id = id.nil? ? 'me' : "users/#{id}"
    end

    def get
      request(id)
    end

  end
end
