require 'spec_helper'
require 'minisculus/mark_1'


describe Engines::Mark_I do
  describe '#encode' do
    let(:engine) {Engines::Mark_I.new}
    
    it {
      assert {engine.encode('ac') == 'fh'}
    }
    it {
      assert {engine.encode(' ') == '4'}
    }
  end
  
  describe '#decode' do
    let(:engine) {Engines::Mark_I.new}
    
    it 'read an encoded string' do
      secret = 'blue'
      assert {engine.decode(engine.encode(secret)) == secret}
    end
  end
end