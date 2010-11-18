require 'spec_helper'
require 'minisculus/engines'


describe Engines.mark_I do
  let(:engine) {Engines.mark_I}
  describe '#encode' do
    it {
      assert {engine.encode('ac') == 'fh'}
    }
    it {
      assert {engine.encode(' ') == '4'}
    }
  end
  
  describe '#decode' do
    it 'read an encoded string' do
      secret = 'blue'
      assert {engine.decode(engine.encode(secret)) == secret}
    end
  end
end