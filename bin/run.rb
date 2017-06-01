require_relative '../config/environment'

cli = CLI.new()

cli.clear_table
cli.welcome

3.times do
  cli.display_players
  cli.user1_draft
  cli.display_players
  cli.user2_draft
end

cli.display_teams
cli.game_summary
# #do that until all players are gone
# user_team_display
# play_game
# end_game?
