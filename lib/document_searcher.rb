require 'awesome_print'
class DocumentSearcher
  def initialize(search_document:)

    if search_document.is_a? String
      @search_document = File.open(search_document)
    elsif search_document.is_a? File or search_document.is_a? Tempfile
      @search_document = search_document.open
    else
      raise 'Invalid type for search_document. Must be File object or String path to file.'
    end
  end

  def search_for_localized_terms(search_term_one:, search_term_two:, search_term_distance: 1)
    search_document_string = @search_document.read.downcase
    search_term_one = search_term_one.downcase
    search_term_two = search_term_two.downcase

    if search_document_string.size <= 0
      return false
    end

    if search_term_one.strip.empty? or search_term_two.strip.empty?
      return false
    end

    begin
      search_term_distance = search_term_distance.to_i
      search_term_distance = 1 if search_term_distance < 1
    rescue
      return false
    end

    match_one = search_document_string.match(/#{search_term_one}/)
    match_two = search_document_string.match(/#{search_term_two}/)

    unless match_one and match_two
      return false
    end

    m = search_document_string.match(/\b(?:#{search_term_one}\W+(?:\w+\W+){1,#{search_term_distance}}?#{search_term_two}|#{search_term_two}\W+(?:\w+\W+){1,#{search_term_distance}}?#{search_term_one})\b/)

    m.nil? ? false : m
  end
end