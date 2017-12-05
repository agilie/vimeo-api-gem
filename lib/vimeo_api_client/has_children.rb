require 'vimeo_api_client/utils'

module Vimeo
  module HasChildren

    include Utils

    def has_many(resource_plural)

      define_method "#{resource_plural}" do |id = nil|
        klass = Object.const_get "Vimeo::#{snake_to_camel(singularize(resource_plural))}"
        klass.new(id, self.id)
      end

    end

    def self.included(base)
      base.extend(HasChildren)
    end

  end
end

