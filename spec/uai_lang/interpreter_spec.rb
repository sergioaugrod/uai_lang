require 'spec_helper'

RSpec.describe UaiLang::Interpreter do
  subject { described_class.new }

  describe '#eval' do
    it 'execute some code' do
      code = <<-CODE
        b = 5
      CODE

      result = subject.eval(code)
      expect(result).to eq nil
    end
  end
end
