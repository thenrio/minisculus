require 'typhoeus'
require 'yajl'

module Minisculus
  class Question
    # errors
    class NotAcceptable < StandardError
      attr_reader :code
      def initialize(code=406, message=nil)
        message ||= 'No message provided, check you post to correct url'
        super("#{message} (code : #{code})")
        @code = code
      end
    end
    
    attr_accessor :uri, :params, :instructions, :message
    def initialize(uri)
      uri = uri[1..-1] if uri[0] == '/'
      self.params = Question.default_params
      self.uri = uri
    end
    
    def read
      s = Typhoeus::Request.get(uri, params).body
      hash = Yajl::Parser.new.parse(s)
      self.instructions = hash['reference-url']
      self.message = hash['question']
      self
    end
    
    def answer(&block)
      answer = self.instance_eval(&block) if block
      content = Yajl::Encoder.encode({'answer' => answer})
      response = Typhoeus::Request.put(uri, params.merge(:body => content))
      case response.code
      when 303
        Question.new(response.headers_hash['Location'])
      else
        raise NotAcceptable.new(response.code, response.body)
      end
    end

    def self.default_params
      {:headers => {'Accept' => 'application/json', 'Content-Type' => 'application/json'}}
    end

    def uri
      "http://minisculus.edendevelopment.co.uk/#{@uri}"
    end
  end
end
