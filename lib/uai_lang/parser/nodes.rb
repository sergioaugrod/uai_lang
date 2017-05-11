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

      def eval(context)
        UaiLang::Runtime::Eval.new(nodes, context).execute
      end
    end
  end
end
