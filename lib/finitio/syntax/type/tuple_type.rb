module Finitio
  module Syntax
    module TupleType
      include Node

      capture :heading

      def compile(factory)
        factory.send(kind, heading.compile(factory))
      end

      def to_ast
        [ :"#{kind}_type", heading.to_ast ]
      end

    private

      def kind
        heading.multi? ? :multi_tuple : :tuple
      end

    end # module TupleType
  end # module Syntax
end # module Finitio
