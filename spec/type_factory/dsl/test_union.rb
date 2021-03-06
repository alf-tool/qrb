require 'spec_helper'
module Finitio
  describe TypeFactory, "DSL#union" do

    let(:factory){ TypeFactory.new }

    shared_examples_for "The Int|Float union type" do

      it{ should be_a(UnionType) }

      it 'should have the correct candidates' do
        expect(subject.candidates).to eq([intType, floatType])
      end
    end

    before do
      subject
    end

    context 'when used with the standard signature' do
      subject{
        factory.union([Integer, Float], 'MyUnion')
      }

      it_should_behave_like "The Int|Float union type"

      it 'should have the correct name' do
        expect(subject.name).to eq("MyUnion")
      end
    end

    context 'when used with the standard signature and no name' do
      subject{
        factory.union([Integer, Float])
      }

      it_should_behave_like "The Int|Float union type"

      it 'should have the correct name' do
        expect(subject.name).to eq("Integer|Float")
      end
    end

    context 'when used with a list of ruby classes' do
      subject{
        factory.union(Integer, Float)
      }

      it_should_behave_like "The Int|Float union type"

      it 'should have the correct name' do
        expect(subject.name).to eq("Integer|Float")
      end
    end

    context 'when used with a list of types' do
      subject{
        factory.union(intType, floatType)
      }

      it_should_behave_like "The Int|Float union type"

      it 'should have the correct name' do
        expect(subject.name).to eq("intType|floatType")
      end
    end

    context 'when used with a mix of both' do
      subject{
        factory.union(Integer, floatType)
      }

      it_should_behave_like "The Int|Float union type"

      it 'should have the correct name' do
        expect(subject.name).to eq("Integer|floatType")
      end
    end

  end
end
