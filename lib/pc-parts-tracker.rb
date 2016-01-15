require 'json'
require 'open-uri'
require 'nokogiri'
require 'redditkit'

[
  "pcpartpicker-parser.rb"
].each do |file_name|
  require File.expand_path("../pc-parts-tracker/#{file_name}", __FILE__)
end
