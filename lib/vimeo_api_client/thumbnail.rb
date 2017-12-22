require 'vimeo_api_client/client'

module Vimeo
  class Thumbnail

    include Client

    attr_reader :id, :parents

    def initialize(id = nil, parents = {})
      @id = id
      @parents = parents
    end

    def index
      get("/videos/#{video_id}/pictures")
    end

    def show
      get("/videos/#{video_id}/pictures/#{@id}")
    end

    def create(options)
      response = post("/videos/#{video_id}/pictures", options)
      upload_file(response.link, options[:file]) if options[:file]
      response
    end

    def upload_file(upload_link, file)
      HTTParty.put(upload_link, body: file)
    end

    def update(options)
      patch("/videos/#{video_id}/pictures/#{@id}", options)
    end

    def destroy
      delete("/videos/#{video_id}/pictures/#{@id}")
    end

    def video_id
      parents[:video_id]
    end

  end
end
