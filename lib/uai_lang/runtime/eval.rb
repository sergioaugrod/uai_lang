module UaiLang
  module Runtime
    class Eval
      def initialize(nodes, context)
        @nodes = nodes
        @context = context
      end

      def execute
        value = Globals['nil']

        nodes.each do |node|
          value = eval_node(node)
        end

        value
      end

      private

      attr_reader :nodes, :context

      def eval_node(node)
        send("eval_#{node.type}".to_sym, node)
      end

      def eval_number(node)
        Globals['Number'].new(node.value)
      end

      def eval_string(node)
        Globals['String'].new(node.value)
      end

      def eval_true(node)
        Globals['true']
      end

      def eval_false(node)
        Globals['false']
      end

      def eval_nil(node)
        Globals['nil']
      end

      def eval_def(node)
        method = UaiLang::Runtime::Method.new(node.params, node.body)
        context.current_class.runtime_methods[node.name] = method
      end

      def eval_call_node(node)
        if node.receiver
          value = eval_node(node.receiver)
        else
          value = context.current_self
        end

        arguments = node.arguments.map { |arg| eval_node(arg) }

        value.call(node.method, arguments)
      end

      def eval_get_constant(node)
        Globals[node.name]
      end

      def eval_set_constant(node)
        Globals[node.name] = eval_node(node.value)
      end

      def eval_get_local(node)
        context.locals[node.name]
      end

      def eval_set_local(node)
        context.locals[node.name] = eval_node(node.value)
      end
    end
  end
end
