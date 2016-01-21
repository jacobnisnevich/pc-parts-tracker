require 'sinatra'
require 'json'

require File.expand_path('../lib/pc-parts-tracker.rb', __FILE__)

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/listParts' do
  parts_parser = PCPartPickerParser.new(params["partsId"])
  parts = parts_parser.list_parts

  reddit_searcher = RedditSearcher.new
  parts_with_deals = reddit_searcher.GetPartsDeals(parts)

  parts_with_deals.to_json
end
