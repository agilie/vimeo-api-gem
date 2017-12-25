require 'vimeo_api_client/utils'

module Vimeo
  module HasChildren

    include Utils

    def has_many(resource_plural)

      define_method "#{resource_plural}" do |uri = nil|
        klass = Object.const_get "Vimeo::#{snake_to_camel(singularize(resource_plural))}"
        class_name = self.class.class_name
        parents = self.parents.merge("#{class_name}_id".to_sym => self.id)
        klass.new(uri, parents)
      end

    end

    def self.included(base)
      base.extend(HasChildren)
    end

  end
end

