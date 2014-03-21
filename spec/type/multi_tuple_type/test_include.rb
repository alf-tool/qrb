require 'spec_helper'
module Finitio
  describe MultiTupleType, "include?" do

    let(:heading){
      Heading.new([
        Attribute.new(:a, intType),
        Attribute.new(:b, intType, false)
      ])
    }

    let(:type){ MultiTupleType.new(heading) }

    subject{ type.include?(arg) }

    context 'when a valid hash and both attributes' do
      let(:arg){ {a: 12, b: 14} }

      it{ should be_true }
    end

    context 'when a valid hash but no optional attribute' do
      let(:arg){ {a: 12} }

      it{ should be_true }
    end

    context 'when an invalid hash (too many attributes)' do
      let(:arg){ {a: 12, c: 15} }

      it{ should be_false }
    end

    context 'when an invalid hash (too few attributes)' do
      let(:arg){ {b: 12} }

      it{ should be_false }
    end

    context 'when an invalid hash (wrong type)' do
      let(:arg){ {a: 12, b: 15.0} }

      it{ should be_false }
    end

    context 'when an invalid hash (wrong type II)' do
      let(:arg){ {a: 12.0, b: 15} }

      it{ should be_false }
    end

  end
end
