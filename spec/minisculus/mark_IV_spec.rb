require 'spec_helper'
require 'minisculus/engines'

describe "Mark_IV" do
  let(:machine) {Minisculus::Engines.mark_IV}
  it 'is reversible, as "decode(encode(secret)) == secret"' do
    assert {machine.encode('The') == 'JMl'}
    assert {machine.decode('JMl') == 'The'}
  end
end