#!/usr/bin/ruby

# Benjamin Elijah Griffin
# 2017 
# Because I wanted a lot of different random strings, and _Lorem Ipsum_ isn't
# good for different *looking* strings.

# 2701-0.txt is the "UTF-8" version of _Moby Dick_ from the Gutenburg
# website. There is also a 2701.txt (ASCII) in the ftp site.
# There might be other slight differences between the two. I used
# the -0 version.

book = '2701-0.txt'
digest = 'moby-digest.txt'
start = 'Call me Ishmael'
final = 'End of Project Gutenberg'

require 'getoptlong'

opts = GetoptLong.new(
  [ '--help', GetoptLong::NO_ARGUMENT ],
  [ '--input', '-i', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--output', '-o', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--start', '-s', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--end', '-e', GetoptLong::REQUIRED_ARGUMENT ]
)

opts.each do |opt, arg|
  case opt
    when '--help'
      puts <<-EOF
hello [OPTION] ... DIR

--help            show this help

--input  BOOK     read from book file
     -i  BOOK        default '#{book}'

--output DIGEST   write to digest file
      -o DIGEST      default '#{digest}'

--start  TEXT     start with the line containing TEXT (included in digest)
     -s  TEXT        default '#{start}'

--end    TEXT     end if the line contains TEXT (not included in digest)
   -e    TEXT        default '#{final}'
      EOF

    when '--input'
      book = arg

    when '--output'
      digest = arg

    when '--start'
      start = arg

    when '--end'
      final = arg
  end
end

m = File.open(book, 'r')
d = File.open(digest, 'w')

accum = ''
state = 'start'

def process(fh,line)
  # no shouting
  return if line =~ /[A-Z]{5,}/
  # no markdown/html meta
  return if line =~ /[*_&<>\[\]]/

  fh.puts line.chomp.gsub(/\s+/, " ")
end

m.each_line do |line|
  
  case state
    when 'start'
      if line.match(start)
        state = 'working'
	accum = line
      end
   
    when 'working'
      if line.match(final)
        state = 'done'
        process(d,accum)
      elsif line =~ /^\s*$/
	state = 'new'
        process(d,accum)
      else
        accum += line
      end 

    when 'new'
      if line.match(final)
        state = 'done'
      elsif line =~ /[a-z]/
        state = 'working'
	accum = line
      end  
  end
end
