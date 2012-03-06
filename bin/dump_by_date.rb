#!/usr/bin/env ruby
## dump daily quake data

require File.dirname(__FILE__)+'/../bootstrap'

date = ARGV.empty? ? Date.today-1 : Date.parse(ARGV.shift)

Quake.find_by_date(date).asc(:time).each do |q|
  puts "#{q.place} #{q.time} - magnitude:#{q.magnitude}, depth:#{q.depth}"
end
