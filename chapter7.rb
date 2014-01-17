def beer

  count = 99
  while count >= 0
    puts count.to_s + ' bottles of beer on the wall. ' + count.to_s + ' bottles of beer.'
    puts 'Take one down, pass it around.'
    count -= 1
  end
end

def grandma

  bye_count = 3

  puts 'Talk to grandma'
  while  bye_count > 0
    talk = gets.chomp
    if talk == talk.upcase &&  talk != 'BYE'
      puts 'NO, NOT SINCE ' + Random.rand(1930..1950).to_s
    else
      if talk == 'BYE'
        bye_count -= 1
      else
        bye_count = 3
      end

      puts 'HUH?!  SPEAK UP, SONNY!'
    end

  end

end

def leep()

  puts 'Enter the year to start'
  start_year = gets.chomp
  puts 'Enter the year to end'
  end_year = gets.chomp
  year = start_year.to_i
  while year <= end_year.to_i
    if ((year % 400 == 0) || (year % 100 != 0 && year % 4 == 0))
      puts year.to_s + " is a leap year."
    end
    year += 1
  end

end

puts 'Run the beer code'
beer()
puts 'Run the grandma code'
grandma()
puts 'Run the leap year code'
leep()

