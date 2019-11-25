#!/usr/bin/ruby

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
  elsif (!$words.include?("#{guess}\n"))
    puts "That's not a word. Guess a real word."
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

def total_guesses(before, after, guess)
  total = before.length + after.length
  total +=1 if guess != ''
  return total
end

def calculate_duration(start_time, end_time)
  (end_time - start_time).to_i
end

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

puts "In this game, I choose a word, and you guess my word. When you guess, I'll tell you if your word is before or after mine."

$words = File.readlines('/usr/share/dict/words')
$current_word = $words.sample.downcase.chomp!

$before_guesses = []
$after_guesses = []
$start_time = Time.now
guess_loop()
