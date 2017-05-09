module UaiLang
  module Parser
    class Nodes
      attr_accessor :nodes

      def initialize(nodes = [])
        @nodes = nodes
      end

      def <<(node)
        nodes << node
        self
      end
    end
  end
end
