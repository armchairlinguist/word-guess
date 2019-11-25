#!/usr/bin/ruby

# Take in a guess and process it, then loop back if not a terminal condition.
def guess_loop()
  context = provide_context($before_guesses, $after_guesses)
  puts context
  
  print "Guess: "
  input = gets
  guess = input.downcase.chomp

  total = total_guesses($before_guesses, $after_guesses, guess)

  if (guess == $current_word)
    time = calculate_duration($start_time, Time.now)
    puts "You got it in #{total} guesses over #{time} seconds! Nice work."
  elsif (guess == "")
    time = calculate_duration($start_time, Time.now)
    puts "Giving up after #{total} guesses and #{time} seconds?\nThe answer was \"#{$current_word}\". Try again later."
  elsif (!$words.include?(guess))
    puts "That word isn't in the list. Guess again."
    guess_loop()
  elsif (guess < $current_word)
    print "Try again. "
    $before_guesses << guess
    guess_loop()
  elsif (guess > $current_word)
    print "Try again. "
    $after_guesses << guess
    guess_loop()
  end
end

# How many guesses?
def total_guesses(before, after, guess)
  total = before.length + after.length
  total +=1 if guess != ''
  return total
end

# Basic timer. Uses seconds.
def calculate_duration(start_time, end_time)
  (end_time - start_time).to_i
end

# Give the most recent guesses on each side if available.
def provide_context(before, after)
  context = ""
  if (before.length > 0)
    context << "My word is after #{before.last}. "
  end
  if (after.length > 0)
    context << "My word is before #{after.last}."
  end
  return context
end

# Is there a config file specifying a valid word list?
if File.exist?('./config')
  path = File.read('./config')
  path.chomp!
  if File.exist?(path)
    $words = File.readlines(path)
  else
    puts "You configured a word file that doesn't exist. Trying the defaults."
  end
end

# Otherwise, read one of the default word files, or give up
if File.exist?('/usr/share/dict/words')
  $words = File.readlines('/usr/share/dict/words')
elsif File.exist?('/usr/dict/words')
  $words = File.readlines('/usr/dict/words')
else
  puts "No valid config and no default word lists exist. Provide a path to a wordlist file in `config`."
end

# Clean the list and choose a word
$words.map!{|w| w.downcase.chomp!}
$current_word = $words.sample

# Set up some variables
$before_guesses = []
$after_guesses = []
$start_time = Time.now

# Explain the game and play!
puts "In this game, I choose a word, and you guess my word. When you guess, I'll tell you if your word is before or after mine."
guess_loop()
