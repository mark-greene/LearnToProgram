def sort_words

  sorted_words = []

  puts 'Enter words to be sorted'

  words = gets.chomp
  while  !words.empty?
    sorted_words.push words.split(/[\s,]+/)
    words = gets.chomp
  end

  sorted_words = sorted_words.sort

  sorted_words.each do |word|
    puts word
  end

end

def table_of_content

  line_width = 70

  table = [  ["Table of Contents"],
                  ["Chapter", "Title", "Page"],
                  ["------------", "--------------------", "---------"],
                  ["Chapter 1:", "Getting Started", "Page 1"],
                  ["Chapter 2:", "Numbers", "Page 9"],
                  ["Chapter 3:", "Letters", "Page 13"]  ]

#  table.each do | line |
#    puts  line.length.to_s + " " + line.to_s
#  end

  puts
  puts table[0][0].to_s.center( line_width )
  puts
  for i in 1..table.length-1
    puts table[i][0].to_s.ljust( line_width/3 ) +  table[i][1].to_s.ljust( line_width/3 ) + table[i][2].to_s.ljust( line_width/3 )
  end
  puts

end

sort_words()
table_of_content()
