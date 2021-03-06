require 'spec_helper'
module Finitio
  describe Syntax, "sub_type" do

    subject{
      Syntax.parse(input, root: "sub_type")
    }

    let(:compiled){
      subject.compile(type_factory)
    }

    let(:ast){
      subject.to_ast
    }

    context '.Integer( i | i >= 0 )' do
      let(:input){ '.Integer( i | i >= 0 )' }

      it 'compiles to a SubType' do
        expect(compiled).to be_a(SubType)
        expect(compiled.super_type).to be_a(BuiltinType)
        expect(compiled.super_type.ruby_type).to be(Integer)
      end

      it 'has the expected AST' do
        expect(ast).to eq([
          :sub_type,
          [:builtin_type, "Integer"],
          [:constraint, "default", [:fn, [:parameters, "i"], [:source, "i >= 0"]]]
        ])
      end

      it 'is equal to the same type' do
        j = Syntax.parse(input, root: "sub_type").compile(type_factory)
        expect(j).to eq(compiled)
      end
    end

    context '.Integer( i | positive: i >= 0 )' do
      let(:input){ '.Integer( i | positive: i >= 0 )' }

      it 'compiles to a SubType' do
        expect(compiled).to be_a(SubType)
        expect(compiled.super_type).to be_a(BuiltinType)
        expect(compiled.super_type.ruby_type).to be(Integer)
      end

      it 'has the correct constraints' do
        expect(compiled.constraints.map(&:name)).to eq([:positive])
      end

      it 'has the expected AST' do
        expect(ast).to eq([
          :sub_type,
          [:builtin_type, "Integer"],
          [:constraint, "positive", [:fn, [:parameters, "i"], [:source, "i >= 0"]]]
        ])
      end
    end

    context '.Integer( i | positive: i >= 0, ... )' do
      let(:input){ '.Integer( i | positive: i >= 0, small: i <= 255 )' }

      it 'compiles to a SubType' do
        expect(compiled).to be_a(SubType)
        expect(compiled.super_type).to be_a(BuiltinType)
        expect(compiled.super_type.ruby_type).to be(Integer)
      end

      it 'has the correct constraints' do
        expect(compiled.constraints.map(&:name)).to eq([:positive, :small])
      end

      it 'has the expected AST' do
        expect(ast).to eq([
          :sub_type,
          [:builtin_type, "Integer"],
          [:constraint, "positive", [:fn, [:parameters, "i"], [:source, "i >= 0"]]],
          [:constraint, "small",    [:fn, [:parameters, "i"], [:source, "i <= 255"]]]
        ])
      end
    end

  end
end
