require 'vimeo_api_client/client'
require 'vimeo_api_client/has_children'

module Vimeo
  class Album

    include Client
    include HasChildren

    attr_reader :id, :parents

    def initialize(id = nil, parents = {})
      @id = id
      @parents = parents
    end

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

    def user_id
      parents[:user_id]
    end

  end
end
