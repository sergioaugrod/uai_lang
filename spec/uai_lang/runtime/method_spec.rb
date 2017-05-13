require 'spec_helper'

RSpec.describe UaiLang::Runtime::Method do
  let(:params) { [] }
  let(:body) { double(Proc) }

  subject { described_class.new(params, body) }

  describe '#call' do
    let(:context) { double(UaiLang::Runtime::Context) }
    let(:object) { double(UaiLang::Runtime::Object) }

    before do
      allow(UaiLang::Runtime::Context).to receive(:new).and_return(context)
    end

    it 'calls method' do
      expect(body).to receive(:eval).with(context)

      subject.call(object, params)
    end
  end
end
