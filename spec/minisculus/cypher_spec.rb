require 'spec_helper'
require 'minisculus/cypher'

describe Minisculus::Cypher::ShiftingWheel do
  CHARSET = %w(0 1 2 3)
  let(:cypher) {Minisculus::Cypher::ShiftingWheel.new(1, CHARSET)}
  
  it 'code shift offset letters to right' do
    assert {cypher.encode('013') == '120'}
  end
  
  it 'decode shift offset letters to left' do
    assert {cypher.decode('120') == '013'}
  end
end


describe Minisculus::Cypher::SelfTurningWheel do
  CHARSET = %w(0 1 2 3)
  let(:will) {will = Minisculus::Cypher::SelfTurningWheel.new(CHARSET)}
  it 'has initial position 0' do
    assert {will.offset == 0}
  end
  
  describe "#encode" do
    context 'three chars' do
      it 'third is shift of 2 * "index of second secret letter in charset"' do
        will.secret = '100'
        assert {will.encode('111') == '131'}
      end      
    end
    
    it 'encoding twice same string produce same result' do
      will.secret = '1'
      assert {will.encode('1') == will.encode('1')}
    end
  end
  
  describe "hoffset(i, uncrypted)" do
    it "it is two times index of uncrypted[i] in charset" do
      assert {will.hoffset(0, '333') == 6}
    end
  end
end

