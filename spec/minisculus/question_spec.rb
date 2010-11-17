require 'spec_helper'
require 'typhoeus'
require 'yajl'

module Minisculus  
  class Question
    attr_accessor :uri, :content_url, :message
    def initialize(uri)
      self.uri = uri
    end
    
    def read
      s = Typhoeus::Request.get(uri, :headers => headers)
      hash = Yajl::Parser.new.parse(s)
      self.content_url = hash['reference-url']
      self.message = hash['question']
      self
    end
    
    def answer(&block)
      answer = yield message
      content = Yajl::Encoder.encode({'answer' => answer})
      response = Typhoeus::Request.put(uri, :body => content, :headers => headers)
    end

    def self.headers
      {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    end

    def uri
      if @uri =~ /^http:/
        @uri
      else
        "http://minisculus.edendevelopment.co.uk#{@uri}"
      end 
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
      q = Minisculus::Question.new('/234')
      q.content_url = 'oh'; q.message = 'ha'
      q
    }
    
    it 'put to minisculus site, as json, transformed message using given block' do
      url = 'http://minisculus.edendevelopment.co.uk/234'
      content = '{"answer":"code"}'
      mock(Typhoeus::Request).put(url, :body => content, :headers => Minisculus::Question.headers) {
        Typhoeus::Response.new(:code => 303)
      }
      response = question.answer {|message| 'code'}
      assert {response.code == 303}
    end
  end
end