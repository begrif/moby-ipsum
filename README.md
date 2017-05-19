Moby Ipsum
----------

Because _Lorem Ipsum_ is sometimes rather dull. And _Moby Dick_ is a classic.
And also, sometimes you want random strings that *look different* from each
other.

This digests a book, assumed to have blank lines between paragraphs, and 
headers and footers to ignore; discarding lines with meta-characters that
may impede easy usage, and then uses that digest to print text.

This is **not** a Markov generator, the output includes entire paragraphs
of the source selected to meet word count demands.

## Requirements

Go to the [Gutenberg Project](http://gutenberg.org/ebooks/2701/) and download a book, such
as _Moby Dick_. Preprocess it with the `prep-moby.rb` script:

     ruby prep-moby --input 2701-0.txt --output moby-digest.txt \
		--start 'Call me Ismael' --end 'End of Project Gutenberg'

## Usage

     require 'moby-generator.rb'

     moby = Moby_generator.new("moby-digest.txt")

     # short strings
     (1..50).each { |n| puts moby.somewords(n) }

     # long strings
     (500..5500).step(500) { |n| puts moby.lotsofwords(n) + "\n\n" }

## History

version 0.1 Benjamin Elijah Griffin, released May 2017

## License

Licensed under the [Perl Artistic License (2.0)](http://www.perlfoundation.org/artistic_license_2_0/)

Your source text of choice may or may not have a license, too. Gutenberg
Project books certainly do.
