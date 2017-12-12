require 'vimeo_api_client/client'

module Vimeo
  class WatchlaterVideo

    include Client

    attr_reader :id

    def initialize(id = nil, user_id)
      @id = id
      @user_id = user_id
    end

    def add
      put("#{@user_id}/watchlater/#{@id}")
    end

    def check
      get("#{@user_id}/watchlater/#{@id}")
    end

    def remove
      delete("#{@user_id}/watchlater/#{@id}")
    end

    def index
      get("#{@user_id}/watchlater")
    end

  end
end
