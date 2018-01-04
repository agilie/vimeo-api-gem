require 'vimeo_api_client/has_children'

module Vimeo
  class Album < Resource

    include HasChildren

    def create(options)
      post("#{user_id}/albums", options)
    end

    def index(options = {})
      get("#{user_id}/albums", options)
    end

    def show(options = {})
      get("#{user_id}/albums/#{id}", options)
    end

    def update(options)
      patch("#{user_id}/albums/#{id}", options)
    end

    def destroy
      delete("#{user_id}/albums/#{id}")
    end

    # TODO: Maybe refactor method params
    def add_video(video_id)
      put("#{user_id}/albums/#{id}/videos/#{video_id}")
    end

    def add_videos(video_ids)
      videos = video_ids.join(', ')
      put("#{user_id}/albums/#{id}/videos", videos: videos)
    end

    def get_videos(options = {})
      get("#{user_id}/albums/#{id}/videos", options)
    end

    def get_video(video_id, options = {})
      get("#{user_id}/albums/#{id}/videos/#{video_id}", options)
    end

    def delete_video(video_id)
      delete("#{user_id}/albums/#{id}/videos/#{video_id}")
    end
    
  end
end
