require 'rspec'
require 'tempfile'
require 'document_searcher'

describe DocumentSearcher do
  describe '#search_for_localized_terms' do

    before(:each) do
      @tempfile = Tempfile.new('test')
      @tempfile.write('this is a test')
    end

    after(:each) do
      @tempfile.close
      @tempfile.unlink
    end

    context 'if search_document param is not a string or File/Tempfile type' do
      it 'raises an exception' do
        expect {DocumentSearcher.new(search_document: 1234)}.to raise_error(RuntimeError)
      end
    end

    context 'if search_document file does not exist or is not readable' do
      it 'raises an exception' do
        expect {DocumentSearcher.new(search_document: './this_doesnt_exist.txt')}.to raise_error(RuntimeError)
      end
    end

    context 'if document is empty' do
      it 'returns false' do
        @tempfile = Tempfile.new('test')
        @tempfile.write('')
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: 'bar', search_term_two: 'baz')
        expect(search_result).to eq(false)
      end
    end

    context 'if search terms are empty' do
      it 'returns false' do
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: ' ', search_term_two: 'baz')
        expect(search_result).to eq(false)
      end
    end

    context 'if search_term_one not in document' do
      it 'returns false' do
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: 'foo', search_term_two: 'test')
        expect(search_result).to eq(false)
      end
    end

    context 'if search_term_two not in document' do
      it 'returns false' do
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: 'this', search_term_two: 'foo')
        expect(search_result).to eq(false)
      end
    end

    context 'if search_term_distance is not an integer' do
      it 'returns false' do
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: 'this', search_term_two: 'test', search_term_distance: 'ab')
        expect(search_result).to eq(false)
      end
    end

    context 'if search terms are found but not within distance' do
      it 'returns false' do
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: 'this', search_term_two: 'test', search_term_distance: 1)
        expect(search_result).to eq(false)
      end
    end

    context 'if search terms are found and within distance' do
      it 'returns true' do
        document_searcher = DocumentSearcher.new(search_document: @tempfile)
        search_result = document_searcher.search_for_localized_terms(search_term_one: 'this', search_term_two: 'test', search_term_distance: 5)
        expect(search_result).to be_a(String)
      end
    end
  end
end
