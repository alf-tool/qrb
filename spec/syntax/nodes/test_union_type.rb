require 'spec_helper'
module Finitio
  describe Syntax, "union_type" do

    subject{
      Syntax.parse(input, root: "union_type")
    }

    describe "compilation result" do
      let(:compiled){
        subject.compile(type_factory)
      }

      context '.Integer|.Float' do
        let(:input){ '.Integer|.Float' }

        it 'compiles to a UnionType' do
          expect(compiled).to be_a(UnionType)
          expect(compiled).to eq(UnionType.new([intType, floatType]))
        end
      end
    end

    describe "AST" do
      let(:input){ '.Integer|.Float' }

      let(:ast){ subject.to_ast }

      it{ expect(ast).to eq([
          :union_type,
          [:builtin_type, "Integer"],
          [:builtin_type, "Float"]
        ])
      }
    end

  end
end
