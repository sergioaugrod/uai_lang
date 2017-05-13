require 'spec_helper'

RSpec.describe UaiLang::Runtime::Eval do
  let(:nodes) do
    [
      UaiLang::Parser::Node.new(:string, { value: '5' })
    ]
  end
  let(:context) { double(UaiLang::Runtime::Context) }

  subject { described_class.new(nodes, context) }

  describe '#execute' do
    it 'returns object with value 5' do
      result = subject.execute

      expect(result).to be_a(UaiLang::Runtime::Object)
      expect(result.value).to eq '5'
    end
  end
end
