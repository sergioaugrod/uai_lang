require 'spec_helper'

RSpec.describe UaiLang::Runtime::Object do
  let(:origin_class) { double(UaiLang::Runtime::Class) }

  subject { described_class.new(origin_class) }

  describe '#call' do
    let(:method) { double(Proc) }
    let(:arguments) { [10] }

    it 'runs method' do
      expect(origin_class).to receive(:run_method)
        .with(:print).and_return(method)

      expect(method).to receive(:call).with(subject, arguments)

      subject.call(:print, arguments)
    end
  end
end
