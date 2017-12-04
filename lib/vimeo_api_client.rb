require 'vimeo_api_client/version'
require 'vimeo_api_client/configuration'

# Respources
require 'vimeo_api_client/user'

module Vimeo
  extend Configuration

  RESOURCES = %w(user).freeze

  class << self
    RESOURCES.each do |resource|
      define_method resource do |resource_id = nil|
        klass_name(resource).new(resource_id)
      end
    end

    private

    def klass_name(resource)
      "Vimeo::#{resource.capitalize}".split('::').inject(Object) {|o, c| o.const_get c}
    end
  end

end
