module Vimeo
  class Thumbnail < Resource

    def index(options = {})
      get("/videos/#{video_id}/pictures", options)
    end

    def show(options = {})
      get("/videos/#{video_id}/pictures/#{@id}", options)
    end

    def create(options)
      response = post("/videos/#{video_id}/pictures", options)
      upload_file(response.link, options[:file]) if options[:file]
      response
    end

    def upload_file(upload_link, file)
      put(upload_link, file)
    end

    def update(options)
      patch("/videos/#{video_id}/pictures/#{@id}", options)
    end

    def destroy
      delete("/videos/#{video_id}/pictures/#{@id}")
    end

  end
end
