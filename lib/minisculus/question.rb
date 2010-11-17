require 'typhoeus'
require 'yajl'

module Minisculus
  class Question
    attr_accessor :uri, :content_url, :message
    def initialize(uri)
      uri = uri[1..-1] if uri[0] == '/'
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
      answer = self.instance_eval(&block) if block
      content = Yajl::Encoder.encode({'answer' => answer})
      response = Typhoeus::Request.put(uri, :body => content, :headers => headers)
      case response.code
      when 303
        Question.new(response.headers_hash['Location'])
      end
    end

    def self.headers
      {'Accept' => 'application/json', 'Content-Type' => 'application/json'}
    end

    def uri
      "http://minisculus.edendevelopment.co.uk/#{@uri}"
    end
    
    def headers
      self.class.headers
    end
  end
end
