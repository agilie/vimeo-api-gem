module Vimeo
  class Language < Resource

    def index
      get('/languages')
    end

  end
end
