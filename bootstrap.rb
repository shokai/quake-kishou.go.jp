require 'rubygems'
require 'bundler'
require 'bson'
require 'mongoid'
require 'yaml'
require 'json'
require 'kconv'

begin
  @@conf = YAML::load open(File.dirname(__FILE__)+'/config.yml').read
rescue => e
  STDERR.puts 'config.yaml load error!'
  STDERR.puts e
  exit 1
end

Mongoid.configure do |conf|
  host = @@conf['mongo']['host']
  port = @@conf['mongo']['port']
  conf.master = Mongo::Connection.new.db(@@conf['mongo']['database'])
end

[:helpers, :models].each do |dir|
  Dir.glob(File.dirname(__FILE__)+"/#{dir}/*.rb").each do |rb|
    puts "load #{rb}"
    require rb
  end
end
