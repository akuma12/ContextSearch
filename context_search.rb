#!/usr/bin/env ruby
require './lib/document_searcher'
require 'optparse'

OptionParser.new do |parser|
  parser.banner = "Usage: context_search.rb directory_to_search search_term_one search_term_two [search_term_distance]\n"
  parser.banner += "If searching for phrases, surround each search term with double quotes."

  # Whenever we see -n or --name, with an
  # argument, save the argument.
  parser.on("-h", "--help", "Show this help message.") do
    puts parser
    exit
  end

  @directory_to_search = ARGV[0]
  @search_term_one = ARGV[1]
  @search_term_two = ARGV[2]
  @search_term_distance = ARGV[3]

  unless @directory_to_search and @search_term_one and @search_term_two
    puts parser
    exit
  end

end.parse!

Dir.glob("#{@directory_to_search}/*").each do |file|
  document_searcher = DocumentSearcher.new(search_document: file)
  search_result = document_searcher.search_for_localized_terms(search_term_one: @search_term_one, search_term_two: @search_term_two, search_term_distance: @search_term_distance)
  puts "'#{search_result}' found in file #{file}" if search_result
end
