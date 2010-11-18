require 'spec_helper'
require 'minisculus/cypher'

describe Cypher::Device::Will_III do
  let(:will) {Cypher::Device::Will_III.new(%w(0 1 2 3))}
  
  describe "#encode" do
    it 'does not touch first character' do
      assert {will.encode('2') == '2'}
    end
  end
end