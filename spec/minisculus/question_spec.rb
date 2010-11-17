require 'spec_helper'
require 'minisculus/question'

describe Minisculus::Question do
  describe Minisculus::Question::NotAcceptable do
    it 'to_s should have code' do
      assert {Minisculus::Question::NotAcceptable.new(719, 'nuked').to_s =~ /\(code : 719\)/}
    end
  end
  
  describe '.default_params' do
    it 'should set accept and content type as json' do
      assert {Minisculus::Question.default_params[:headers]['Accept'] == 'application/json'}
      assert {Minisculus::Question.default_params[:headers]['Content-Type'] == 'application/json'}
    end
  end
  
  describe '#read' do
    let(:question) {Minisculus::Question.new('/1')}
    
    it 'get page from minisculus site' do
      url, message = "oh", "ha"
      mock(Typhoeus::Request).get(question.uri, question.params) {
        Typhoeus::Response.new(:body => "{\"reference-url\":\"#{url}\",\"question\":\"#{message}\"}")
      }

      question.read()

      assert {question.instructions == "#{Minisculus::Question.eden}/oh"}
      assert {question.message == 'ha'}
    end
  end
  
  describe '#answer' do
    let(:question) {
      q = Minisculus::Question.new('/234')
      q.message = 'ha'
      q
    }
    
    it 'puts to minisculus site, as json, transformed message using given block' do
      content = '{"answer":"ha"}'
      mock(Typhoeus::Request).put(question.uri, question.params.merge(:body => content)) {
        Typhoeus::Response.new(:code => 303)
      }
      question.answer {message}
    end
    
    describe 'when response is redirect' do
      before do
        mock(Typhoeus::Request).put(anything, anything) {
          Typhoeus::Response.new(:code => 303, :headers_hash => {'Location' => '/next-question'})
        }
      end
      it 'should return a new question' do
        next_question = question.answer
        assert {next_question.class == Minisculus::Question}
        assert {next_question.uri =~ /\/next-question$/}
      end
    end
    
    describe 'when response is not accepted' do
      before do        
        mock(Typhoeus::Request).put(anything, anything) {
          Typhoeus::Response.new(:code => 418)
        }
      end
      it 'should raise' do
        error = rescuing {question.answer}
        assert {error.class == Minisculus::Question::NotAcceptable}
        assert {error.message =~ /^No message provided, check you post to correct url/}
        assert {error.code == 418}
      end
    end
  end
end