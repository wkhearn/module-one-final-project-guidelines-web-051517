require 'csv'
answer = gets.chomp.to_i
case answer
  when 1
    puts " "
    puts "-" * 25
    puts "Game 1 - Cleveland Cavaliers at Golden State Warriors"
    CSV.foreach("./db/seeds/Game 1 - Cleveland Cavaliers at Golden State Warriors - 06022016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  when 2
    puts " "
    puts "-" * 25
    puts "Game 2 - Cleveland Cavaliers at Golden State Warriors"
    CSV.foreach("./db/seeds/Game 2 - Cleveland Cavaliers at Golden State Warriors - 06052016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  when 3
    puts " "
    puts "-" * 25
    puts "Game 3 - Golden State Warriors at Cleveland Cavaliers"
    CSV.foreach("./db/seeds/Game 3 - Golden State Warriors at Cleveland Cavaliers - 06082016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  when 4
    puts " "
    puts "-" * 25
    puts "Game 4 - Golden State Warriors at Cleveland Cavaliers"
    CSV.foreach("./db/seeds/Game 4 - Golden State Warriors at Cleveland Cavaliers - 06102016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  when 5
    puts " "
    puts "-" * 25
    puts "Game 5 - Cleveland Cavaliers at Golden State Warriors"
    CSV.foreach("./db/seeds/Game 5 - Cleveland Cavaliers at Golden State Warriors - 06132016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  when 6
    puts " "
    puts "-" * 25
    puts "Game 6 - Golden State Warriors at Cleveland Cavaliers"
    CSV.foreach("./db/seeds/Game 6 - Golden State Warriors at Cleveland Cavaliers - 06162016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  when 7
    puts " "
    puts "-" * 25
    puts "Game 7 - Cleveland Cavaliers at Golden State Warriors"
    CSV.foreach("./db/seeds/Game 7 - Cleveland Cavaliers at Golden State Warriors - 06192016 - Basics.csv", :headers => true, :header_converters => :symbol ) do |row|
      Player.create(row.to_hash)
    end
  else
    "Please make a valid game selection"
end
