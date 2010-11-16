require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  require "bundler/setup"

  Bundler.require(:test)
  require 'wrong/adapters/rspec'

  $LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
end

Spork.each_run do
end

  

