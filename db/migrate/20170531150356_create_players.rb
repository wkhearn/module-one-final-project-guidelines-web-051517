class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :player_name
      t.integer :player_points
      t.boolean :available?, :default => true
    end
  end
end
