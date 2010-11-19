require 'spec_helper'
require 'minisculus/machine'

module Cypher
  def decode(head, tail, memo)
  end
  
  def uncrypt(c, _uncrypted)
    'X'
  end
end

describe Minisculus::Machine do
  CHARSET = %w(0 1 2 3)
  let(:cypher) {Object.new.extend(Cypher)}
  let(:serial) {Minisculus::Machine.new([cypher])}
  
  describe "#decode" do
    it 'will call cypher to uncrypt each character, knowing what is decoded yet' do
      serial.decode('12').should == 'XX'
    end
  end
end