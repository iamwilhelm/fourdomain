#!/usr/bin/ruby

# Generate combinations of two four letter words for domains. You can choose to
# favorite, blacklist either word, or skip to the next.

words = []
favs = []

File.open("words.txt") do |fr|
  fr.each do |line|
    word = line.chomp
    next if word.length != 4
    words << word
  end
end

def generateName(words)
  rnd = Random.new(Time.now.to_i)
  return [words[rnd.rand(words.length)], words[rnd.rand(words.length)]]
end

command = nil
current_word = generateName(words)

while (command != 'q') do
  puts "The current word I came up with is:"
  puts
  puts current_word.join("")
  puts

  puts "(n)ext (p)rev (s)tar (d)elete '#{current_word[0]}' (f)delete '#{current_word[1]}' (q)uit"
  puts
  puts

  begin
    system("stty raw -echo")
    command = STDIN.getc
  ensure
    system("stty -raw echo")
  end

  case command.chomp
  when 'n'
    current_word = generateName(words)
  when 'p'
    next
  when 's'
    favs << current_word.join("")
  when 'd'
    puts "Removed word: #{words.delete(current_word[0])}"
  when 'f'
    puts "Removed word: #{words.delete(current_word[1])}"
  when 'q'
    break
  end
end

puts "Your favorite words: #{favs}"
