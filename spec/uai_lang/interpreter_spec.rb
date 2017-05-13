require 'spec_helper'

RSpec.describe UaiLang::Interpreter do
  subject { described_class.new }

  describe '#eval' do
    it 'execute some code' do
      code = <<-CODE
        b = 5
        print(b)
      CODE

      result = subject.eval(code)

      expect(result).to be_a(UaiLang::Runtime::Object)
      expect(result.value).to be_nil
    end
  end
end
