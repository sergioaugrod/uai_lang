require 'spec_helper'

RSpec.describe UaiLang::Runtime::Class do
  subject { described_class.new }

  describe '#run_method' do
    it 'runs defined method' do
      subject.define_method(:print) do |message|
        puts(message)
      end

      method = subject.run_method(:print)
      expect(method).to be_a(Proc)
    end
  end

  describe '#define_method' do
    it 'defines hello method' do
      subject.define_method(:print) do |message|
        puts(message)
      end

      expect(subject.self_methods.count).to eq 1
    end
  end

  describe '#new' do
    it 'returns object' do
      object = subject.new

      expect(object).to be_a(UaiLang::Runtime::Object)
      expect(object.value).to be_a(UaiLang::Runtime::Object)
    end
  end

  describe '#new_with_value' do
    it 'returns object' do
      object = subject.new_with_value(10)

      expect(object).to be_a(UaiLang::Runtime::Object)
      expect(object.value).to eq 10
    end
  end
end
