require 'spec_helper'
require 'minisculus/cypher'

describe Minisculus::Cypher::SelfTurningWheel do
  CHARSET = %w(0 1 2 3)
  let(:will) {will = Minisculus::Cypher::SelfTurningWheel.new(CHARSET)}
  it 'has initial position 0' do
    assert {will.offset == 0}
  end
  
  describe "#encode" do
    context 'one char' do
      it 'first character is the same' do
        will.secret = '1'
        assert {will.encode('0') == '0'}
      end
    end
    
    context 'two chars' do
      it 'second is shift of 2 * "index of previous in charset"' do
        will.secret = '11'
        assert {will.encode('11') == '13'}
      end      
    end
    
    it 'encoding twice same string produce same result' do
      will.secret = '1'
      assert {will.encode('1') == will.encode('1')}
    end
    
    it 'encodes JXU as JMl' do
      engine = Minisculus::Cypher::SelfTurningWheel.new
      engine.secret = 'The'
      assert {engine.encode('JXU') == 'JMl'}
    end
  end
end