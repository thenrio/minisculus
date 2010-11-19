$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'minisculus/engines'

message = %q(QT4e8MJYVhkls.27BL9,.MSqYSi'IUpAJKWg9Ul9p4o8oUoGy'ITd4d0AJVsLQp4kKJB2rz4dxfahwUa\"Wa.MS!k4hs2yY3k8ymnla.MOTxJ6wBM7sC0srXmyAAMl9t\"Wk4hs2yYTtH0vwUZp4a\"WhB2u,o6.!8Zt\"Wf,,eh5tk8WXv9UoM99w2Vr4!.xqA,5MSpWl9p4kJ2oUg'6evkEiQhC'd5d4k0qA'24nEqhtAQmy37il9p4o8vdoVr!xWSkEDn?,iZpw24kF\"fhGJZMI8nkI).gsub('\\', '')

def brute_force_hacking
  (0...Minisculus::DEFAULT_CHARSET.length).each do |i|
    (0...Minisculus::DEFAULT_CHARSET.length).each do |j|
      s = Minisculus::Engines::mark_IV([i,j]).decode(message)
      puts("[#{i}, #{j}] => #{s}") if s =~ /FURLIN/
    end
  end  
end

require 'benchmark'
Benchmark.bm do |bm|
  bm.report {brute_force_hacking}
end
