#!/usr/bin/env ruby
## dump quake data specified date

require File.dirname(__FILE__)+'/../bootstrap'

date = ARGV.empty? ? Date.today-1 : Date.parse(ARGV.shift)

places = Hash.new{|h,k| h[k] = {:count => 0, :lat => 0} }

Quake.find_by_date(date).asc(:time).map{|q|
  places[q.place][:count] += 1
  places[q.place][:lat] = q.point['lat']
}

puts "#{date.year}年#{date.month}月#{date.day}日の震度3以上の地震 " + places.keys.map{|name|
  place = places[name]
  {
    :count => place[:count],
    :name => name,
    :lat => place[:lat]
  }
}.sort{|a,b| b[:lat] <=> a[:lat] }.map{|place|
  "#{place[:name]}#{place[:count]}回"
}.join(' ')
