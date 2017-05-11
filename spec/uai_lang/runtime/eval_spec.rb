require 'spec_helper'

RSpec.describe UaiLang::Runtime::Eval do
  subject { described_class.new([], nil) }

  describe '#execute' do
    it { expect(subject.execute).to eq nil }
  end
end
