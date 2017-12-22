module Vimeo
  class WatchlaterVideo < Resource

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

  end
end
