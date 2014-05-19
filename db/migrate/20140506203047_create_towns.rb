class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns, id: false do |t|
      t.primary_key :grepo_id
      t.integer :player_id
      t.string :name
      t.integer :island_x
      t.integer :island_y
      t.integer :slot
      t.integer :points
      t.string :ocean
      t.string :coordinates

      t.timestamps
    end
    add_index :towns, :grepo_id
    add_index :towns, :player_id
    add_index :towns, :name
    add_index :towns, :island_x
    add_index :towns, :island_y
    add_index :towns, :slot
    add_index :towns, :points
  end
end
