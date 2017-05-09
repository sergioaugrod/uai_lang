module UaiLang
  module Parser
    class Node
      def initialize(type, args)
        args.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        @type = type
      end
    end
  end
end
