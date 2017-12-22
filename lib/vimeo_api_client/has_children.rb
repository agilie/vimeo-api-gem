require 'vimeo_api_client/utils'

module Vimeo
  module HasChildren

    include Utils

    def has_many(resource_plural)

      define_method "#{resource_plural}" do |id = nil, parents = {}|
        klass = Object.const_get "Vimeo::#{snake_to_camel(singularize(resource_plural))}"
        class_name = class_name(self.class)
        parents = self.parents.merge("#{class_name}_id".to_sym => self.id)
        klass.new(id, parents)
      end

    end

    def self.included(base)
      base.extend(HasChildren)
    end

    private

    def class_name(klass)
      klass.to_s.split('::').last.downcase
    end

  end
end

