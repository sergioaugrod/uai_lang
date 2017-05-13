require 'spec_helper'

RSpec.describe UaiLang::Parser::Generator do
  it '#parse' do
    code = <<-CODE
      b = "5"
    CODE

    result = described_class.new.parse(code)
    expect(result.nodes.count).to eq 1
  end
end
