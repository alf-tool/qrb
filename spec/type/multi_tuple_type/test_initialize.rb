require 'spec_helper'
module Finitio
  describe MultiTupleType, "initialize" do

    let(:heading){
      Heading.new([Attribute.new(:a, intType)])
    }

    context 'with a valid heading' do
      subject{ MultiTupleType.new(heading) }

      it{ should be_a(MultiTupleType) }

      it 'correctly sets the instance variable' do
        expect(subject.heading).to eq(heading)
      end
    end

    context 'with an invalid heading' do
      subject{ MultiTupleType.new("foo") }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(ArgumentError, "Heading expected, got `foo`")
      end
    end

  end
end