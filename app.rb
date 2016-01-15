require 'sinatra'
require 'json'
require 'byebug'

require File.expand_path('../lib/pc-parts-tracker.rb', __FILE__)

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/listParts' do
  parts_parser = PCPartPickerParser.new(params["partsId"])
  parts_parser.list_parts.to_json
end
