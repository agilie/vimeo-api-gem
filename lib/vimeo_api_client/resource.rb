require 'vimeo_api_client/client'

module Vimeo
  class Resource

    include Client

    attr_reader :id, :parents

    def initialize(id = nil, parents = {})
      @id = id
      @parents = parents
    end

    def user_id
      parents[:user_id]
    end

    def video_id
      parents[:video_id]
    end

  end
end
