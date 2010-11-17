require 'spec_helper'
require 'minisculus/mark_2'

describe Engines::Mark_II do
  describe '#encode' do
    let(:engine) {Engines::Mark_II.new()}
    
    it 'should encode abc in STU !!' do
      engine.encode('abc').should == 'STU'
    end
  end
end