class User < ActiveRecord::Base
  attr_accessor :name, :user_team
  def initialize(name)
    @name = name
    @user_team = []
  end

  def draft_player(name)
    name = gets.chomp #normalize input to match player name casing/syntax
    drafted_player = player_hash.find {|player,points| player == name} #confirm find method works when iterating through hash
    @user_team << drafted_player
    player_hash.delete {|player,points| player == name} #confirm delete method works when iterating through hash
  end
end
