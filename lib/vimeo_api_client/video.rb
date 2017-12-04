require 'vimeo_api_client/client'

module Vimeo
  class Video

    include Client

    def initialize(uri = nil)
      @uri = uri
    end

    def create_by_pulling(link)
      request('me/videos', { query: {
        type: 'pull',
        link: link
      } }, :post)
    end

    def update_by_pulling(link)
      request("#{@uri}/files", { query: {
        type: 'pull',
        link: link
      } }, :put)
    end

    def get
      request(@uri)
    end

    def update(options = {})
      request("#{@uri}", { query: options }, :patch)
    end

    def update_timeline_events(options)
      request("#{@uri}/timelineevents", { query: options }, :patch)
    end

  end
end
