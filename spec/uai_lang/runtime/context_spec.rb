require 'spec_helper'

RSpec.describe UaiLang::Runtime::Context do
  describe '#new' do
    let(:current_self) { double(UaiLang::Runtime::Object) }
    let(:current_class) { double(UaiLang::Runtime::Class) }

    before { allow(current_self).to receive(:origin_class).and_return(current_class) }

    it 'initialize attributes' do
      instance = described_class.new(current_self)

      expect(instance.locals).to eq({})
      expect(instance.current_self).to eq current_self
      expect(instance.current_class).to eq current_class
    end
  end
end
