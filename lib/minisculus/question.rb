require 'typhoeus'
require 'yajl'

module Minisculus
  class Question
    # error
    class NotAcceptable < StandardError
      attr_reader :code
      def initialize(code=406, message=nil)
        message ||= 'No message provided, check you post to correct url'
        super("#{message} (code : #{code})")
        @code = code
      end
    end
    
    # core
    attr_accessor :uri, :params, :instructions, :message, :code
    def initialize(uri)
      uri = squeeze_leading_slash(uri)
      self.params = Question.default_params
      self.uri = uri
    end
    
    def read
      s = Typhoeus::Request.get(uri, params).body
      hash = Yajl::Parser.new.parse(s)
      self.instructions = squeeze_leading_slash(hash['reference-url'])
      self.message = hash['question']
      self.code = hash['code']
      self
    end
    
    def answer(&block)
      answer = self.instance_eval(&block) if block
      body = Yajl::Encoder.encode({'answer' => answer})
      
      puts "#{self} answers #{body}" if params[:verbose]
      response = Typhoeus::Request.put(uri, params.merge(:body => body))
      case response.code
      when 303
        Question.new(response.headers_hash['Location'])
      else
        raise NotAcceptable.new(response.code, response.body)
      end
    end

    def uri
      "#{Question.eden}/#{@uri}"
    end
    
    def instructions
      "#{Question.eden}/#{@instructions}"
    end

    def self.default_params
      {:headers => {'Accept' => 'application/json', 'Content-Type' => 'application/json'}}
    end

    def self.eden
      'http://minisculus.edendevelopment.co.uk'
    end
    
    def show
      require 'launchy'
      Launchy.open(instructions) if @instructions
    end
    
    private
    def squeeze_leading_slash(s)
      s = s[1..-1] if s[0] == '/'
      s
    end
  end
end
