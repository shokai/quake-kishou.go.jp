#!/usr/bin/env ruby
## dump quake data specified date

require File.dirname(__FILE__)+'/../bootstrap'

if !ARGV.empty? and ARGV.first.to_s.size =~ /^\d{6}$/
  STDERR.puts 'date format error!'
  STDERR.puts "e.g.  ruby #{$0} 201202"
  exit 1
end

if !ARGV.empty? and ARGV.first =~ /^\d{6}/
  year, month = ARGV.shift.scan(/^(\d{4})(\d{2})/)[0].map{|i| i.to_i }
else
  d = Date.today
  year, month = d.year, d.month
end

places = Hash.new{|h,k| h[k] = {:count => 0, :lat => 0} }

Quake.find_by_month(year, month).asc(:time).map{|q|
  places[q.place][:count] += 1
  places[q.place][:lat] = q.point['lat']
}

puts "#{year.to_i}年#{month.to_i}月のマグニチュード3以上の地震 " + places.keys.map{|name|
  place = places[name]
  {
    :count => place[:count],
    :name => name,
    :lat => place[:lat]
  }
}.sort{|a,b| b[:lat] <=> a[:lat] }.map{|place|
  "#{place[:name]}#{place[:count]}回"
}.join(' ')
