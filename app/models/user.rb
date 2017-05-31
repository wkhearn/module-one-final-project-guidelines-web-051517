require "pry"

class User < ActiveRecord::Base
  has_many :players
  has_many :drafts

  def draft_player#(player, user)
    puts "Select a player:"
    name = gets.chomp #normalize input to match player name casing/syntax
    drafted_player = Player.find_by(player_name: name) #confirm find method works when iterating through hash

    #Insert into Game table that user_id has drafted player_id
    drafted_player.user == self
    binding.pry
    #Draft.save #some method to insert user_id and player_id into Game table


    # delete player_id from Player Table
    # player_hash.delete {|player,points| player == name} #confirm delete method works when iterating through hash
  end
end
