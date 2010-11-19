require 'spec_helper'
require 'minisculus/machine'

module Cypher
  def crypt(c, _secret=nil)
    'Z'
  end  
  def uncrypt(c, _uncrypted)
    'X'
  end
end

describe Minisculus::Machine do
  let(:cypher) {Object.new.extend(Cypher)}
  let(:machine) {Minisculus::Machine.new([cypher])}
  
  describe "#decode" do
    it 'will call cypher to uncrypt each character, knowing what is decoded yet' do
      machine.decode('12').should == 'XX'
    end
  end
  
  describe "#encode" do
    it 'will call cypher to uncrypt each character, knowing what is decoded yet' do
      machine.encode('12').should == 'ZZ'
    end    
  end
end