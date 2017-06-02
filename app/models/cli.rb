class CLI

  def welcome
    puts " "
    puts "Welcome to the NBA Boxscore CLI Game!"

    Player.update_all(:available? => true)

    puts "Player 1, please enter your name"
    name1 = gets.chomp.capitalize
    user1 = User.find_or_create_by(name: name1)
    puts " "

    puts "Player 2, please enter your name"
    name2 = gets.chomp.capitalize
    user2 = User.find_or_create_by(name: name2)
    puts " "
  end

  def display_players
    puts "-" * 25
    puts "Available Players"
    puts "-" * 25
    puts " "
    Player.select { |player| if player.available? == true then puts player.player_name end }
    puts " "

    if Player.select{|player| player.available? == false}.length > 0
      puts "-" * 25
      puts "Drafted Players"
      puts "-" * 25
      Player.select { |player| if player.available? == false then puts player.player_name end }
      puts " "
    end
  end

  def user1_draft
    user = User.find(User.minimum(:id))
    puts "-" * 25
    puts "#{user.name}, please choose a player."
    player_name = gets.chomp
    if Player.select {|player| player.player_name.upcase == player_name.upcase && player.available? == true}.length > 0
      # if Player.find_by{|player| player.available? == true}
      player = Player.select {|player| player.player_name.upcase == player_name.upcase}[0]
      draft = Draft.create(user_id: user.id, player_id: player.id)
      Player.update(player.id, :available? => false)
    else
      puts "Please make a valid player selection"
      puts " "
      cli = CLI.new()
      cli.user1_draft
    end
  end

  def user2_draft
    user = User.find(User.maximum(:id))
    puts "-" * 25
    puts "#{user.name}, please choose a player."
    player_name = gets.chomp
    if Player.select {|player| player.player_name.upcase == player_name.upcase && player.available? == true}.length > 0
      player = Player.select {|player| player.player_name.upcase == player_name.upcase}[0]
      draft = Draft.create(user_id: user.id, player_id: player.id)
      Player.update(player.id, :available? => false)
    else
      puts "Please make a valid player selection"
      puts " "
      cli = CLI.new()
      cli.user2_draft
    end
  end


  def display_teams
    user1 = User.find(User.minimum(:id))
    user2 = User.find(User.maximum(:id))

    puts " "
    puts " "
    sleep 1
    puts "...3..."
    sleep 1
    puts "...2..."
    sleep 1
    puts "...1..."
    sleep 1

    puts " "
    puts "#{user1.name}'s Team: "
    puts "-" * 25
    user1.players.each do |player|
      puts "#{player.player_name} -- #{player.player_points} points"
    end

    sleep 2
    puts " "
    puts "#{user2.name}'s Team: "
    puts "-" * 25
    user2.players.each do |player|
      puts "#{player.player_name} -- #{player.player_points} points"
    end
    puts " "
    sleep 2
  end

  def game_summary
    user1 = User.find(User.minimum(:id))
    user2 = User.find(User.maximum(:id))
    team_1_total = user1.players.map {|player| player.player_points}.sum
    team_2_total = user2.players.map {|player| player.player_points}.sum

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
    sleep 2
    puts " "
    puts "-" * 25
    puts "Would you like to play again? Y/N"
    answer = gets.chomp
    while answer != "Y" || answer != "N"
      if answer == "Y"
        puts " "
        cli = CLI.new()
        cli.cli_play
      elsif answer == "N"
        puts "Cya next time!"
        return
      else
        puts "Please make a valid selection"
        answer = gets.chomp
      end
    end
  end

  def clear_table
    User.destroy_all
    Draft.destroy_all
  end

  def cli_play
    cli = CLI.new()
    cli.clear_table
    cli.welcome
    i = 1
    2.times do
      puts " "
      puts "-" * 25
      puts "Beginning of Round #{i}!"
      i += 1
      cli.display_players
      cli.user1_draft
      cli.display_players
      cli.user2_draft
    end
    # tip-off feature?
    cli.display_teams
    cli.game_summary
    cli.end_game?
  end

end
