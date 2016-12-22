#Contextual Word Search

This is an example of a contextual word search; finding documents that contain words or phrases within a a specified 
distance of one another. This is my first real attempt at Test Driven Development; writing the test first with the expectation
of failure, then adding functionality to allow the test to pass. While it certainly took longer to write than if I had just
sat down and written out the class and methods, I do feel that the tests give me much more confidence for future changes.

##Requirements
Ruby 2.1 or above

Bundler

##Usage

`bundle install`

`chmod +x context_search.rb`

`context_search.rb directory_to_search search_term_one search_term_two [search_term_distance]`

`search_term_distance` is the maximum number of words between the two search terms or phrases. Default: `1`

To search for phrases, surround search terms with double quotes:

`context_search.rb ./docs "Happy Birthday" "To You" 30`

This will search for the phrases "Happy Birthday" and "To You" within 30 words of each other.

If there is a positive match, the section of the file containing both words/phrases will be displayed, along with the 
name of the file containing it, one file per line.

```
'insensible possession oh particular attachment at excellence in. the books' found in file ./docs/doc1.txt
'books whose front would purse if be do decay. quitting you way formerly disposed perceive ladyship are. common turned boy direct and yet.
 
 difficulty on insensible' found in file ./docs/doc2.txt
```

##Testing
`bundle exec rspec`

