#!/usr/bin/ruby

require './moby-generator.rb'

moby = Moby_generator.new("moby-digest.txt")

# short strings
(1..50).each { |n| puts moby.somewords(n) }

# long strings
(500..5500).step(500) { |n| puts moby.lotsofwords(n) + "\n\n" }
