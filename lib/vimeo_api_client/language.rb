require 'vimeo_api_client/client'

module Vimeo
  class Language

    include Client

    attr_reader :id

    def initialize(uri = nil)
    end

    def index
      get('/languages')
    end

  end
end
