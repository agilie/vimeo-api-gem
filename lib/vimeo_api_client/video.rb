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

    def upload_by_streaming(file_url, options)
      file = File.open(file_url, 'rb')
      file_size = file.size
      offset = options[:offset].to_i
      file.read(offset)
      headers = {
        'Content-Length' => file_size.to_s,
        # 'Content-Type' => 'determine or get from options',
      }
      headers['Content-Range'] = "bytes #{offset + 1}-#{file_size}/#{file_size}" unless offset.zero?
      HTTParty.put(options[:upload_link_secure], body: file.read, headers: headers)
    end

    def verify_upload_by_streaming(options)
      headers = {
        'Content-Length' => '0',
        'Content-Range': 'bytes */*'
      }
      HTTParty.put(options[:upload_link_secure], headers: headers)
    end

    def finish_upload_by_streaming(options)
      delete(options[:complete_uri])
    end

    def stream(file_url, options = {})
      tries = options[:tries] || 3
      file_size = File.size?(file_url)
      uploaded_size = 0
      ticket = create_by_streaming

      loop do
        upload_by_streaming(file_url, ticket.merge(offset: uploaded_size))
        resp = verify_upload_by_streaming(ticket)
        uploaded_size = resp.headers['range'].split('-')[1].to_i
        tries -= 1
        break if file_size >= uploaded_size || tries <= 0
      end

      response = finish_upload_by_streaming(ticket)
      ::Hashie::Mash.new(video_url: response.headers['location'])
    end

  end
end
