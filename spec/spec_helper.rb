require "rubygems"
require "bundler/setup"

Bundler.require(:test)
require 'wrong/adapters/rspec'

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
  

