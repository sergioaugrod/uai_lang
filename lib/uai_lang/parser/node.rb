module UaiLang
  module Parser
    class Node
      attr_reader :type

      def initialize(type, args)
        args.each do |key, value|
          instance_variable_set("@#{key}", value)

          self.class.send(:define_method, key) do
            instance_variable_get("@#{key}")
          end
        end

        @type = type
      end
    end
  end
end
