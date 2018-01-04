module Vimeo
  class Category < Resource

    def index(options = {})
      get('/categories', options)
    end

    def show(options = {})
      get("/categories/#{id}", options)
    end

    private

    def get_id(uri)
      # TODO: Implement uri parsing i.e. categories/{category}
      @id = uri
    end

  end
end
