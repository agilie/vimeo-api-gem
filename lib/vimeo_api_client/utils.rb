module Vimeo
  module Utils

      def singularize(string)
        string[0...-1]
      end

      def pluralize(string)
        "#{string}s"
      end

      def snake_to_camel(string)
        string.split('_').collect(&:capitalize).join
      end

      def class_name(klass)
        klass.to_s.split('::').last.downcase
      end

  end
end

