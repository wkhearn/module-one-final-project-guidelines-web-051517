class CLI < ActiveRecord::Base

  def welcome
    puts "Welcome, Player 1. Please enter your name"
    name1 = gets.chomp
    user1 = User.new(name1)

    puts "Welcome, Player 2. Please enter your name"
    name2 = gets.chomp
    user2 = User.new(name2)
  end


  def display_players
    puts "Here are your available players"
    player_hash.each do |player, points|
      puts player
    end
  end

  def user_team_display
    puts "Here is Player 1's team: "
    user1.user_team.each {|player| puts player.name} #format this output
    puts "Here is Player 2's team: "
    user2.user_team.each {|player| puts player.name}
  end

  def play_game
    #this iterates through each team and grab/sum points values of each team
    team_1_points = user1.user_team.values.inject(:+)
    team_2_points = user2.user_team.values.inject(:+)
    if team_1_points > team_2_points
      puts "User 1 wins!"
    elsif team_2_points > team_1_points
      puts "User 2 wins!"
    else
      puts "You actually tied. That's brutal. This isn't soccer."
    end
  end

  def end_game?
    puts "Would you like to play again? Y/N"
    answer = gets.chomp
    if answer == "Y"
      #start game over using loop?
    elsif answer == "N"
      break
    else
      puts "Please make a valid selection"
      #loop back to beginning of end_game method
    end
  end
end
