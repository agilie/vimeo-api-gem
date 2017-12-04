module Vimeo
  module Configuration

    OPTIONS = [
      :client_id,
      :client_secret,
      :token
    ].freeze

    attr_accessor *OPTIONS

    def config
      yield self
    end

  end
end
