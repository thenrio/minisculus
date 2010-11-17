require 'spec_helper'
require 'minisculus/question'

describe Minisculus::Question do
  describe '.headers' do
    it 'should set accept and content type as json' do
      assert {Minisculus::Question.headers['Accept'] == 'application/json'}
      assert {Minisculus::Question.headers['Content-Type'] == 'application/json'}
    end
  end
  
  describe '#read' do
    let(:question) {Minisculus::Question.new('/1')}
    
    it 'get page from minisculus site' do
      url, message = "oh", "ha"
      mock(Typhoeus::Request).get('http://minisculus.edendevelopment.co.uk/1', :headers => Minisculus::Question.headers) {
        "{\"reference-url\":\"#{url}\",\"question\":\"#{message}\"}"
      }

      question.read()

      assert {question.content_url == 'oh'}
      assert {question.message == 'ha'}
    end
  end
  
  describe '#answer' do
    let(:question) {
      q = Minisculus::Question.new('/234')
      q.content_url = 'oh'; q.message = 'ha'
      q
    }
    
    it 'puts to minisculus site, as json, transformed message using given block' do
      content = '{"answer":"ha"}'
      mock(Typhoeus::Request).put(question.uri, :body => content, :headers => Minisculus::Question.headers) {
        Typhoeus::Response.new(:code => 303)
      }
      question.answer {message}
    end
    
    describe 'when response is redirect' do
      it 'should return a new question' do
        mock(Typhoeus::Request).put(anything, anything) {
          Typhoeus::Response.new(:code => 303, :headers_hash => {'Location' => '/next-question'})
        }
        next_question = question.answer
        assert {next_question.class == Minisculus::Question}
        assert {next_question.uri =~ /\/next-question$/}
      end
    end
  end
end