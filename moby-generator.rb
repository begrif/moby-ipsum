# Benjamin Elijah Griffin
# 2017 
# Because I wanted a lot of different random strings, and _Lorem Ipsum_ isn't
# good for different *looking* strings.

class Moby_generator
  # In moby-digest.txt, there's 4 or more of every wordcount up to 125,
  # and 10 or more of every wordcount up to 40. 155 is the first zero.
  Maxwords = 150
  
  # Intended source is moby-digest.txt which is _Moby Dick_ as
  # one paragraph per line, with a few lines dropped (eg,
  # stuff with markdown / html metacharacters).
  def initialize(filename)
    fh = File.open(filename, 'r')
    @book = Array.new

    fh.each_line do |line|
      # Melville likes his extra-hyphated-words, so we need to split on
      # whitespace and hypens.
      #    Besides, passengers get sea-sick—grow quarrelsome—don’t sleep
      #    Entering that gable-ended Spouter-Inn
      # etc
      wc = line.split(/[- ]+/).count

      if wc <= Maxwords
	if @book[wc] == nil
	  @book[wc] = [line]
	else
	  if wc < 11
	    # take all the short ones
	    @book[wc].push(line)
	  else
	    # and some of the long ones
	    if @book[wc].count < 9
	      @book[wc].push(line)
	    elsif rand(12) == 7
	      # and sometimes mix-it-up
	      @book[wc][rand(@book[wc].count)] = line
	    end
	  end
	end
      end
    end

  end # initialize

  # Geared for small bits of text, if you ask this for something too long,
  # you'll get a lot more repeating text.
  # returns one line of wc words
  def somewords(wc)
    out = ''
    return out if wc < 1
    # guard against bad array population
    if @book[wc].class.to_s == 'Array'
      out = @book[wc][rand(@book[wc].count)]
    else
      half = wc / 2
      out = self.somewords(half).chomp + ' ' + self.somewords(wc-half)
    end
    out
  end
  
  # Geared for larger blocks of text, uses somewords() to build the
  # block up from many random sized groups.
  # returns one long line of wc words
  def lotsofwords(wc)
    out = ''
    return out if wc < 1

    while wc > Maxwords
      chunk = rand(Maxwords)
      out = out + self.somewords(chunk).chomp + ' '
      wc -= chunk
    end
    out = out + self.somewords(wc)
  end

end
