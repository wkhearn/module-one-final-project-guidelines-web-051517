class CLI

  def welcome
    puts "Welcome to the NBA Boxscore CLI Game!"

    Player.update_all(:available? => true)

    puts "Player 1, please enter your name"
    name1 = gets.chomp
    user1 = User.find_or_create_by(name: name1)
    puts " "

    puts "Player 2, please enter your name"
    name2 = gets.chomp
    user2 = User.find_or_create_by(name: name2)
    puts " "
  end

  def display_players
    puts "Please select a player from below:"
    puts "-" * 25
    puts " "
    puts "Available Players"
    puts "-" * 25
    Player.select { |player| if player.available? == true then puts player.player_name end }
    puts "-" * 25
    puts "Drafted Players"
    puts "-" * 25
    Player.select { |player| if player.available? == false then puts player.player_name end }
    puts " "
  end

  def user1_draft
    user = User.find(User.minimum(:id))
    puts "#{user.name}, please choose a player."
    player_name = gets.chomp
    player = Player.find_by(player_name: player_name)
    draft = Draft.create(user_id: user.id, player_id: player.id)
    Player.update(player.id, :available? => false)
  end

  def user2_draft
    user = User.find(User.maximum(:id))
    puts "#{user.name}, please choose a player."
    player_name = gets.chomp
    player = Player.find_by(player_name: player_name)
    draft = Draft.create(user_id: user.id, player_id: player.id)
    Player.update(player.id, :available? => false)
  end


  def display_teams
    user1 = User.find(User.minimum(:id))
    user2 = User.find(User.maximum(:id))

    puts " "
    puts "#{user1.name}'s Team: "
    puts "-" * 25

    user1.players.each do |player|
      puts "#{player.player_name} -- #{player.player_points} points"
    end

    puts " "
    puts "#{user2.name}'s Team: "
    puts "-" * 25

    user2.players.each do |player|
      puts "#{player.player_name} -- #{player.player_points} points"
    end
    puts " "
  end

  def game_summary
    user1 = User.find(User.minimum(:id))
    user2 = User.find(User.maximum(:id))

    team_1_total = user1.players.map {|player| player.player_points}.sum
    team_2_total = user2.players.map {|player| player.player_points}.sum

    puts "Team 1 scored #{team_1_total}."
    puts "Team 2 scored #{team_2_total}."

    if team_1_total > team_2_total
      puts "Player 1 wins! Congrats #{user1.name}!!!!!"
    elsif team_2_total > team_1_total
      puts "Player 2 wins! Congrats #{user2.name}!!!!!"
    else
      puts "What happened...? A tie? This isn't soccer..."
    end
  end


  # # def end_game?
  # #   puts "Would you like to play again? Y/N"
  # #   answer = gets.chomp
  # #   if answer == "Y"
  # #     #start game over using loop?
  # #   elsif answer == "N"
  # #     break
  # #   else
  # #     puts "Please make a valid selection"
  # #     #loop back to beginning of end_game method
  # #   end
  # # end

  def clear_table
    User.destroy_all
    Draft.destroy_all
  end

end
