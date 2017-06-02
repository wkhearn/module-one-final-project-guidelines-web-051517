require "pry"

class CLI

  def welcome
    puts " "
    puts "Welcome to the NBA Boxscore CLI Game!"

    puts "Player 1, please enter your name"
    name1 = gets.chomp.capitalize
    user1 = User.create(name: name1) #find or create unnecessary if we're clearing the user table
    puts " "

    puts "Player 2, please enter your name"
    name2 = gets.chomp.capitalize
    user2 = User.create(name: name2)
    puts " "
  end

  def choose_game
    puts "Which game would you like to choose?"
    puts "1. Game 1 - Cleveland Cavaliers at Golden State Warriors"
    puts "2. Game 2 - Cleveland Cavaliers at Golden State Warriors"
    puts "3. Game 3 - Golden State Warriors at Cleveland Cavaliers"
    puts "4. Game 4 - Golden State Warriors at Cleveland Cavaliers"
    puts "5. Game 5 - Cleveland Cavaliers at Golden State Warriors"
    puts "6. Game 6 - Golden State Warriors at Cleveland Cavaliers"
    puts "7. Game 7 - Cleveland Cavaliers at Golden State Warriors"
    load("db/seeds.rb")
  end

  def display_players
    puts "-" * 25
    puts "Available Players"
    puts "-" * 25
    puts " "
    Player.select { |player| if player.available? == true then puts "#{player.id}. #{player.player_name}" end }
    puts " "

    if Player.select{ |player| player.available? == false }.length > 0
      puts "-" * 25
      puts "Drafted Players"
      puts "-" * 25
      Player.select { |player| if player.available? == false then puts "#{player.player_name} - #{player.user.name}" end }
      puts " "
    end
  end


  def user1_draft
    user = User.find(User.minimum(:id))
      puts "-" * 25
      puts "#{user.name}, please choose a player."
      player_id = gets.chomp.to_i
      if Player.select { |player| player.id == player_id && player.available? == true }.length > 0
        draft = Draft.create(user_id: user.id, player_id: player_id)
        Player.update(player_id, :available? => false)
      else
        puts "Please make a valid player selection"
        puts " "
        user1_draft
      end
  end

  def user2_draft
    user = User.find(User.maximum(:id))
    puts "-" * 25
    puts "#{user.name}, please choose a player."
    player_id = gets.chomp.to_i
    if Player.select { |player| player.id == player_id && player.available? == true }.length > 0
      draft = Draft.create(user_id: user.id, player_id: player_id)
      Player.update(player_id, :available? => false)
    else
      puts "Please make a valid player selection"
      puts " "
      user2_draft
    end
  end


  def display_teams
    user1 = User.find(User.minimum(:id))
    user2 = User.find(User.maximum(:id))
    puts "...5...".rjust(20)
    sleep 1
    puts "...4...".rjust(20)
    sleep 1
    puts "...3...".rjust(20)
    sleep 1
    puts "...2...".rjust(20)
    sleep 1
    puts "...1...".rjust(20)
    sleep 1

    puts " "
    puts "#{user1.name}'s Team: "
    puts "-" * 25
    user1.players.each do |player|
      puts "#{player.player_name} -- #{player.player_points} points"
    end

    sleep 1
    puts " "
    puts "#{user2.name}'s Team: "
    puts "-" * 25
    user2.players.each do |player|
      puts "#{player.player_name} -- #{player.player_points} points"
    end
    puts " "
    sleep 1
  end

  def game_summary
    user1 = User.find(User.minimum(:id))
    user2 = User.find(User.maximum(:id))
    team_1_total = user1.players.map { |player| player.player_points }.sum
    team_2_total = user2.players.map { |player| player.player_points }.sum

    puts "#{user1.name}'s team scored #{team_1_total} points."
    puts "#{user2.name}'s team scored #{team_2_total} points."
    sleep 2

    if team_1_total > team_2_total
      puts " "
      puts "Congrats #{user1.name}!!!!!"
    elsif team_2_total > team_1_total
      puts " "
      puts "Congrats #{user2.name}!!!!!"
    else
      puts " "
      puts "What happened...? A tie? This isn't soccer..."
    end
  end


  def end_game?
    sleep 1
    puts " "
    puts "-" * 25
    puts "Would you like to play again? Y/N"
    answer = gets.chomp.upcase
      if answer == "Y"
        puts " "
        cli_play
      elsif answer == "N"
        puts "Cya next time!"
      else
        puts "Please make a valid selection"
        end_game?
      end
  end

  def clear_table
    User.destroy_all
    Draft.destroy_all
    Player.destroy_all
  end

  def cli_play
    clean_database
    clear_table
    welcome
    choose_game
    sleep 1
    i = 1
    2.times do
      puts " "
      puts "-" * 25
      puts "Beginning of Round #{i}!"
      i += 1
      display_players
      user1_draft
      display_players
      user2_draft
    end
    display_players
    puts "Draft complete, press 'Enter' key to continue"
    gets.chomp
    display_teams
    game_summary
    end_game?
  end

  def clean_database
    # File.delete("db/development.db")
    system "rake db:migrate VERSION=0"
    system "rake db:migrate"
  end

end
