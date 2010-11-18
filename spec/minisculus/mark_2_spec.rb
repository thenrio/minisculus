require 'spec_helper'
require 'minisculus/engines'

describe Engines.mark_II do
  let(:engine) {Engines.mark_II([2,5])}
  describe '#encode' do
    it 'should encode abc in STU !!' do
      engine.encode('abc').should == 'STU'
    end
  end
end