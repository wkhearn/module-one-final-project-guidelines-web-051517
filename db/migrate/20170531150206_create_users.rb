class CreateUsers < ActiveRecord::Migration[5.1]
  ActiveRecord::Migration.verbose = false
  def change
    create_table :users do |t|
      t.string :name
    end
  end
end
