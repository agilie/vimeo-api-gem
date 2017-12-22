require 'vimeo_api_client/has_children'

module Vimeo
  class User < Resource

    include HasChildren

    has_many :watchlater_videos
    has_many :albums

    def initialize(id = nil, parents = {})
      @id = id.nil? ? '/me' : "/users/#{id}"
      @parents = parents
    end

    def show
      get(id)
    end

    def add_team_member(email, options = {})
      put("#{@id}/teammembers/#{email}", options)
    end

  end
end
