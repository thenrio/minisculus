require 'spec_helper'
require 'typhoeus'
require 'yajl'

module Minisculus  
  class Question
    attr_accessor :title, :content_url, :message
    def initialize(title)
      self.title = title
    end
    
    def read
      s = Typhoeus::Request.get(question_url, :headers => headers)
      hash = Yajl::Parser.new.parse(s)
      self.content_url = hash['reference-url']
      self.message = hash['question']
    end
    
    def answer(&block)
      answer = yield message
      content = Yajl::Encoder.encode({'answer' => answer})
      Typhoeus::Request.put(question_url, :body => content, :headers => headers)
    end

    def self.headers
      {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    end

    private
    def question_url
      "http://minisculus.edendevelopment.co.uk#{title}"
    end
    
    def headers
      self.class.headers
    end
  end
end

describe Minisculus::Question do
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
      q = Minisculus::Question.new('/start')
      q.content_url = 'oh'; q.message = 'ha'
      q
    }
    
    it 'put to minisculus site, as json, transformed message using given block' do
      url = 'http://minisculus.edendevelopment.co.uk/start'
      content = '{"answer":"code"}'
      mock(Typhoeus::Request).put(url, :body => content, :headers => Minisculus::Question.headers) {
        '???'
      }
      response = question.answer {|message| 'code'}
      assert {response == '???'}
    end
  end
end