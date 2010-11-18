require 'spec_helper'
require 'minisculus/mark_4'
describe Engines::Mark_IV do
  let(:engine) {Engines::Mark_IV.new([2, 5])}

  describe '#encode' do
    it 'encodes a as Mark_II' do
      engine.encode('a').should == 'S'
    end
  end
end