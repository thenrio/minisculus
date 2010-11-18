require 'spec_helper'
require 'minisculus/cypher'

describe Cypher::Device::SelfTurningWheel do
  CHARSET = %w(0 1 2 3)
  let(:will) {Cypher::Device::SelfTurningWheel.new(CHARSET)}
  it 'has initial position 0' do
    assert {will.position == 0}
  end
  
  describe "#encode" do
    context 'one char' do
      it 'first character is the same' do
        assert {will.encode('1') == '1'}
      end
      it 'has a new position' do
        assert {will.position == 2}
      end
    end
    
    context 'two chars' do
      it 'second is shift of 2 * "index of previous in charset"' do
        assert {will.encode('11') == '13'}
      end      
    end
  end
end