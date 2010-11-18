require 'spec_helper'
require 'minisculus/cypher'

describe Cypher::Device::Will_III do
  let(:will) {Cypher::Device::Will_III.new(%w(0 1 2 3))}
  
  describe "#encode" do
    it 'first character is the same' do
      assert {will.encode('1') == '1'}
    end
    it 'second is shift of 2 * "index of previous in charset"' do
      assert {will.encode('11') == '13'}
    end
  end
end