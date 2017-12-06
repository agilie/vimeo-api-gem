require 'vimeo_api_client/client'
require 'vimeo_api_client/has_children'

module Vimeo
  class Video

    include Client
    include HasChildren

    has_many :text_tracks

    attr_reader :id

    def initialize(uri = nil)
      @id = strip_to_id(uri)
    end

    def create_by_pulling(link)
      request('/me/videos', { body: {
        type: 'pull',
        link: link
      } }, :post)
    end

    def update_by_pulling(link)
      request("/videos/#{@id}/files", { body: {
        type: 'pull',
        link: link
      } }, :put)
    end

    def get
      request("/videos/#{@id}")
    end

    def update(options = {})
      request("/videos/#{@id}", { body: options }, :patch)
    end

    def update_timeline_events(options)
      request("/videos/#{@id}/timelineevents", { body: options }, :patch)
    end

    private

    def strip_to_id(uri)
      uri.to_s[/\d+/] if uri
    end

  end
end
