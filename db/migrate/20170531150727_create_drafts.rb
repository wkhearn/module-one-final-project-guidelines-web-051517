class CreateDrafts < ActiveRecord::Migration[5.1]
  ActiveRecord::Migration.verbose = false
  def change
    create_table :drafts do |t|
      t.references :player
      t.references :user
    end
  end
end
