require 'spec_helper'
require 'minisculus/engines'

describe 'Mark_II' do
  let(:engine) {Minisculus::Engines.mark_II([2,5])}
  describe '#encode' do
    it 'should encode abc in STU !!' do
      engine.encode('abc').should == 'STU'
    end
  end
  
  describe '#decode' do
    it 'should encode abc in STU !!' do
      engine.decode('STU').should == 'abc'
    end
  end
end