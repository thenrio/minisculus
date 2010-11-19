require 'spec_helper'
require 'minisculus/machine'

describe Minisculus::Machine do
  CHARSET = %w(0 1 2 3)
  let(:cypher) {mock!}
  let(:serial) {Minisculus::Machine.new([cypher])}
  
  describe "#decode" do
    it 'will call cypher to decode each character, knowing what is decoded yet' do
      serial.decode('12')
    end
  end
end