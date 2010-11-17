require 'rubygems'
require "bundler/setup"

Bundler.require(:test)
require 'wrong/adapters/rspec'

RSpec.configure do |config|
  config.mock_with(:rr)
end

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))

  

