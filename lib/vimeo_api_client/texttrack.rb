require 'vimeo_api_client/client'

module Vimeo
  class TextTrack

    include Client

    def initialize(id = nil, video_id)
      @id = id
      @video_id = video_id
    end

    def index
      request("/videos/#{@video_id}/texttracks")
    end

    def get
      request("/videos/#{@video_id}/texttracks/#{@id}")
    end

    # type
    # language
    # name
    # active
    # file
    def create(options)
      response = request("/videos/#{@video_id}/texttracks", { body: options }, :post)
      response = upload_file(response.link, options[:file]) if options[:file]
      response
    end

    def upload_file(upload_link, file)
      HTTParty.put(upload_link, body: file)
    end

  end
end
