module Vimeo
  class Thumbnail < Resource

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

  end
end
