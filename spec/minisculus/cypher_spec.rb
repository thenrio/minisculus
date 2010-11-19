require 'spec_helper'
require 'minisculus/cypher'

CHARSET = %w(0 1 2 3)

describe Minisculus::Cypher::ShiftingWheel do
  let(:cypher) {Minisculus::Cypher::ShiftingWheel.new(1, CHARSET)}
  
  it 'crypt shift offset char to right' do
    assert {cypher.crypt('0') == '1'}
    assert {cypher.crypt('3') == '0'}
  end
  
  it 'decode shift offset letters to left' do
    assert {cypher.uncrypt('1') == '0'}
    assert {cypher.uncrypt('0') == '3'}
  end  
end


describe Minisculus::Cypher::SelfTurningWheel do
  let(:will) {will = Minisculus::Cypher::SelfTurningWheel.new(CHARSET)}
  
  describe "crypt(char, secret)" do
    it 'returns char when crypted word is empty' do
      assert {will.crypt('1', '') == '1'}
    end
    it 'shifts char by hoffset(secret)' do
      assert {will.crypt('1', '1') == '3'}
    end
  end
  
  describe "hoffset(secret, i)" do
    it "it is two times index of secret[i] in charset" do
      assert {will.hoffset('330', 0) == 6}
      assert {will.hoffset('330', 2) == 0}
      assert {will.hoffset('330') == will.hoffset('330', 2)}
    end
  end
end

