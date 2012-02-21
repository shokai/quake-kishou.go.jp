require 'rubygems'
require 'open-uri'
require 'kconv'
require 'date'

class Quake
  def self.get(date=Date.today-1)
    if date.class != Date
      raise 'Date format error'
    else
      url = "http://www.seisvol.kishou.go.jp/eq/daily_map/japan/#{date.to_s.gsub('-','')}_list.shtml"
    end
    page = open(url).read.toutf8
    page.scan(/<pre>(.+)<\/pre>/im).first.first.split(/[\r\n]/).map{|i|
      i.strip
    }.delete_if{|i|!(i =~ /^\d+/)}.map{|i|
      tmp = i.split(/[^\d\.]+/)
      {
        :place => i.split(/\s+/).last,
        :time => Time.mktime(tmp.shift.to_i, tmp.shift.to_i, tmp.shift.to_i, tmp.shift.to_i, tmp.shift.to_i, tmp.shift.to_i),
        :point => {
          :lat => tmp.shift.to_i+tmp.shift.to_f/60,
          :lon => tmp.shift.to_i+tmp.shift.to_f/60
        },
        :depth => tmp.shift.to_i,
        :magnitude => tmp.shift.to_f
      }
    }
  end
end

if $0 == __FILE__
  ##  ruby -Ku quake.rb
  ##  ruby -Ku quake.rb 20120102
  
  date = ARGV.empty? ? Date.today-1 : Date.parse(ARGV.shift)
  p Quake.get(date)
end
