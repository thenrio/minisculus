require 'spec_helper'
require 'minisculus/cypher'

describe Minisculus::Cypher::SelfTurningWheel do
  CHARSET = %w(0 1 2 3)
  let(:will) {Minisculus::Cypher::SelfTurningWheel.new(CHARSET)}
  it 'has initial position 0' do
    assert {will.offset == 0}
  end
  
  describe "#encode" do
    context 'one char' do
      it 'first character is the same, and offset has moved of 2' do
        assert {will.encode('1') == '1'}
        assert {will.offset == 2}
      end
    end
    
    context 'two chars' do
      it 'second is shift of 2 * "index of previous in charset"' do
        assert {will.encode('11') == '13'}
      end      
    end
    
    it 'encoding twice same string produce same result' do
      assert {will.encode('1') == will.encode('1')}
    end
  end
end