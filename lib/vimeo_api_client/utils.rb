module Vimeo
  module Utils

      def singularize(string)
        string[0...-1]
      end

      def snake_to_camel(string)
        string.split('_').collect(&:capitalize).join
      end

  end
end

