require 'vimeo_api_client/client'
require 'vimeo_api_client/utils'

module Vimeo
  class Resource

    include Client
    include Utils

    attr_reader :id, :parents

    def initialize(uri = nil, parents = {})
      parse_url(uri)
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
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    # TODO: This logic should be less complicated
    # Maybe move this to a class methods
    def parse_url(uri)
      return if uri.nil?
      @id = uri[/^\d+$/]
      @id = get_resource_id(uri, class_name(self.class)) unless @id

      @parents = {}
      (%w[video user] - [class_name(self.class)]).each do |resource|
        resource_id = get_resource_id(uri, resource)
        next if resource_id.nil? || resource_id.empty?

        key = "#{resource}_id".to_sym
        @parents[key] = resource_id
      end
    end

    def get_resource_id(uri, klass_name)
      if klass_name == 'user'
        id = uri[/users\/\d+/]
        return id ? "/users/#{id}" : '/me'
      end
      regex = Regexp.new("#{pluralize(klass_name)}/(\\d+)")
      match = uri.match(regex)
      match[1] if match
    end

  end
end
