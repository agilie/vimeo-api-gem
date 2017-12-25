require 'vimeo_api_client/has_children'

module Vimeo
  class User < Resource

    include HasChildren

    has_many :watchlater_videos
    has_many :albums
    has_many :portfolios

    def show
      get(id)
    end

    def add_team_member(email, options = {})
      put("#{@id}/teammembers/#{email}", options)
    end

    private

    def get_id(uri)
      @id = uri.nil? ? '/me' : super
    end

  end
end
