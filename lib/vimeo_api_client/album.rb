require 'vimeo_api_client/has_children'

module Vimeo
  class Album < Resource

    include HasChildren

    def create(options)
      post("#{user_id}/albums", options)
    end

    def index
      get("#{user_id}/albums")
    end

    def show
      get("#{user_id}/albums/#{id}")
    end

    def update(options)
      patch("#{user_id}/albums/#{id}", options)
    end

    def destroy
      delete("#{user_id}/albums/#{id}")
    end
    
  end
end
