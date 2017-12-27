require 'vimeo_api_client/has_children'

module Vimeo
  class Video < Resource

    include HasChildren

    has_many :text_tracks
    has_many :thumbnails

    def show
      get("/videos/#{id}")
    end

    def update(options = {})
      patch("/videos/#{id}", options)
    end

    def update_timeline_events(options)
      patch("/videos/#{id}/timelineevents", options)
    end

    def destroy
      delete("/videos/#{id}")
    end

    def create_by_pulling(link)
      post('/me/videos', type: 'pull', link: link)
    end

    def update_by_pulling(link)
      put("/videos/#{id}/files", type: 'pull', link: link)
    end

    def create_by_posting(redirect_url)
      post('/me/videos', type: 'post', redirect_url: redirect_url)
    end

    def update_by_posting(redirect_url)
      put("/videos/#{id}/files", type: 'pull', redirect_url: redirect_url)
    end

    def create_by_streaming
      post('/me/videos', type: 'streaming')
    end

    def upload_by_streaming(upload_link, file)
      put(upload_link, file)
    end

    # TODO: This should be implemented in nearest future
    def end_streaming(options)
      delete(options)
    end

  end
end
