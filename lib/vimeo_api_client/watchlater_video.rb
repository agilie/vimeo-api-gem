require 'vimeo_api_client/client'

module Vimeo
  class WatchlaterVideo

    include Client

    attr_reader :id, :parents

    def initialize(id = nil, parents = {})
      @id = id
      @parents = parents
    end

    def add
      put("#{user_id}/watchlater/#{@id}")
    end

    def check
      get("#{user_id}/watchlater/#{@id}")
    end

    def remove
      delete("#{user_id}/watchlater/#{@id}")
    end

    def index
      get("#{user_id}/watchlater")
    end

    def user_id
      parents[:user_id]
    end

  end
end
