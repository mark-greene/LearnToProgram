def beer

  count = 99
  while count >= 0
    puts count.to_s + ' bottles of beer on the wall. ' + count.to_s + ' bottles of beer.'
    puts 'Take one down, pass it around.'
    count = count - 1
  end
end

def grandma

  date = 1938

  puts 'Talk to grandma'
  talk = gets.chomp
  while talk.downcase != 'bye'
    if talk == talk.upcase
      puts 'NO, NOT SINCE ' + date.to_s
    else
      puts 'HUH?!  SPEAK UP, SONNY!'
    end
  end

end

beer()
grandma()
