require 'vimeo_api_client/client'
require 'vimeo_api_client/has_children'

module Vimeo
  class User

    include Client
    include HasChildren

    has_many :watchlater_videos

    attr_reader :id

    def initialize(id = nil, parents = {})
      @id = id.nil? ? '/me' : "/users/#{id}"
    end

    def show
      get(id)
    end

    def add_team_member(email, options = {})
      put("#{@id}/teammembers/#{email}", options)
    end

  end
end
