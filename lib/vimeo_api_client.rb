# Gem version
require 'vimeo_api_client/version'

# Configurations
require 'vimeo_api_client/configuration'
require 'vimeo_api_client/utils'

# Resources
require 'vimeo_api_client/user'
require 'vimeo_api_client/video'
require 'vimeo_api_client/texttrack'

module Vimeo
  extend Configuration

  RESOURCES = %w(user video text_track).freeze

  class << self

    include Utils

    RESOURCES.each do |resource|
      define_method resource do |resource_id = nil|
        klass_name(resource).new(resource_id)
      end
    end

    private

    def klass_name(resource)
      "Vimeo::#{snake_to_camel(resource)}".split('::').inject(Object) {|o, c| o.const_get c}
    end
  end

end
