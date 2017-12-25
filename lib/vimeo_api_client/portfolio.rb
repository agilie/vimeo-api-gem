module Vimeo
  class Portfolio < Resource

    def index(options = {})
      get("#{user_id}/portfolios", options)
    end

    def show(options = {})
      get("#{user_id}/portfolios/#{id}", options)
    end

  end
end
