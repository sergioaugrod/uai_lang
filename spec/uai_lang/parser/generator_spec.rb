require 'spec_helper'

RSpec.describe UaiLang::Parser::Generator do
  it '#parse' do
    code = <<-CODE
      b = 5
    CODE

    result = described_class.new.parse(code)
    symbols = UaiLang::Parser::Nodes.new([
      UaiLang::Parser::Node.new(
        :set_local,
        {
          name: 'b',
          value: UaiLang::Parser::Node.new(:number, { value: '5' })
        }
      )
    ])

    expect(result.nodes.count).to eq 1
  end
end
