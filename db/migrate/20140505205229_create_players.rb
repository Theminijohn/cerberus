class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.primary_key :grepo_id
      t.string :name
      t.integer :alliance_id
      t.integer :points
      t.integer :rank
      t.integer :town_count
      # Bashpoints
      t.integer :all_rank
      t.integer :all_points
      t.integer :def_rank
      t.integer :def_points
      t.integer :att_rank
      t.integer :att_points

      t.timestamps
    end
    add_index :players, :grepo_id
    add_index :players, :name
    add_index :players, :alliance_id
    add_index :players, :points
    add_index :players, :rank
    add_index :players, :town_count
    add_index :players, :all_rank
    add_index :players, :all_points
    add_index :players, :def_rank
    add_index :players, :def_points
    add_index :players, :att_rank
    add_index :players, :att_points
  end
end
