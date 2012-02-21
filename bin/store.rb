#!/usr/bin/env ruby
require File.dirname(__FILE__)+'/../bootstrap'

date = ARGV.empty? ? Date.today-1 : Date.parse(ARGV.shift)

begin
  data = Quake.get(date)
rescue => e
  STDERR.puts "Quakes get error!!"
  STDERR.puts e
  exit 1
end

data.each do |q|
  quake = Quake.new(q)
  if Quake.where(:time => quake.time, :point => quake.point).count > 0
    puts "#{quake.place} #{quake.time} => skipped"
  else
    quake.save
    puts "#{quake.place} #{quake.time} => saved!"
  end
end
