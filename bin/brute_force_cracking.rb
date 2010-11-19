$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'minisculus'
require 'pp'

def code_2_crack
  @code ||= Minisculus::Question.new('finish/50763edaa9d9bd2a9516280e9044d885').read.code
end

def crack(code)
  combinations = {}
  (0...Minisculus::DEFAULT_CHARSET.length).each do |i|
    (0...Minisculus::DEFAULT_CHARSET.length).each do |j|
      s = Minisculus::Engines::mark_IV([i,j]).decode(code)
      if s =~ /FURLIN/
        (combinations[s] ||= []) << [i,j]
      end
    end
  end
  combinations 
end

require 'benchmark'
Benchmark.bm do |bm|
  bm.report do 
     pp crack(code_2_crack)
  end
end
