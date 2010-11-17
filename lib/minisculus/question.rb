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
      return @uri if @uri =~ /^http:/
      "http://minisculus.edendevelopment.co.uk#{@uri}"
    end
    
    def headers
      self.class.headers
    end
  end
end
