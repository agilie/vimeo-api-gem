require 'vimeo_api_client/client'
require 'vimeo_api_client/utils'

module Vimeo
  class Resource

    include Client
    include Utils

    attr_reader :id, :parents

    def initialize(uri = nil, parents = {})
      uri = uri.to_s
      @id = get_id(uri)
      @parents = get_parents(uri)
      @parents.merge!(parents)
    end

    def user_id
      parents[:user_id]
    end

    def video_id
      parents[:video_id]
    end

    protected

    def self.descendants
      ObjectSpace.each_object(Class).select {|klass| klass < self}
    end

    def get_id(uri)
      uri[/^\d+$/] || self.class.get_resource_id(uri)
    end

    def get_parents(uri)
      parents = {}
      (Vimeo::Resource.descendants - [self.class]).each do |klass|
        klass_name = klass.class_name
        resource_id = klass.get_resource_id(uri)
        next if resource_id.nil? || resource_id.empty?
        key = "#{klass_name}_id".to_sym
        parents[key] = resource_id
      end
      parents
    end

    def self.get_resource_id(uri)
      regex = Regexp.new("#{resource_name}/(\\d+)")
      match = uri.match(regex)
      match[1] if match
    end

    def self.class_name
      name.to_s.split('::').last.downcase
    end

    def self.resource_name
      "#{class_name}s"
    end

  end
end
