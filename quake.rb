require 'rubygems'
require 'open-uri'
require 'kconv'
require 'date'

class Quake
  def self.get(date=Date.today-1)
    begin
      url = "http://www.seisvol.kishou.go.jp/eq/daily_map/japan/#{date.to_s.gsub('-','')}_list.shtml"
    rescue => e
      STDERR.puts "HTTP-GET Error : #{url}"
      STDERR.puts e
    end
    
    page = open(url).read.toutf8
    page.scan(/<pre>(.+)<\/pre>/im).first.first.split(/[\r\n]/).map{|i|
      i.strip
    }.delete_if{|i|!(i =~ /^\d+/)}.map{|i|
      tmp = i.split(/\s+/)
      {
        :place => tmp.pop,
        :m => tmp.pop.to_f
      }
    }
  end
end

if $0 == __FILE__
  p Quake.get
end
