require 'vimeo_api_client/client'
require 'vimeo_api_client/has_children'

module Vimeo
  class Video

    include Client
    include HasChildren

    has_many :text_tracks
    has_many :thumbnails

    attr_reader :id

    def initialize(uri = nil)
      @id = strip_to_id(uri)
    end

    def create_by_pulling(link)
      post('/me/videos', type: 'pull', link: link)
    end

    def update_by_pulling(link)
      put("/videos/#{@id}/files", type: 'pull', link: link)
    end

    def show
      get("/videos/#{@id}")
    end

    def update(options = {})
      patch("/videos/#{@id}", options)
    end

    def update_timeline_events(options)
      patch("/videos/#{@id}/timelineevents", options)
    end

    def destroy
      delete("/videos/#{@id}")
    end

    private

    def strip_to_id(uri)
      uri.to_s[/\d+/] if uri
    end

  end
end
