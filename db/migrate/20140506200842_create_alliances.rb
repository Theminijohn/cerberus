class CreateAlliances < ActiveRecord::Migration
  def change
    create_table :alliances, id: false do |t|
      t.primary_key :grepo_id
      t.string :name
      t.integer :points
      t.integer :town_count
      t.integer :member_count
      t.integer :rank
      # Bashpoints
      t.integer :all_rank
      t.integer :all_points
      t.integer :def_rank
      t.integer :def_points
      t.integer :att_rank
      t.integer :att_points

      t.timestamps
    end
    add_index :alliances, :grepo_id
    add_index :alliances, :name
    add_index :alliances, :points
    add_index :alliances, :town_count
    add_index :alliances, :member_count
    add_index :alliances, :rank
    add_index :alliances, :all_rank
    add_index :alliances, :all_points
    add_index :alliances, :def_rank
    add_index :alliances, :def_points
    add_index :alliances, :att_rank
    add_index :alliances, :att_points
  end
end
