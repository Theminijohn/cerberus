class CreateIslands < ActiveRecord::Migration
  def change
    create_table :islands, id: false do |t|
      t.primary_key :grepo_id
      t.integer :island_x
      t.integer :island_y
      t.integer :type_number
      t.integer :available_towns
      t.string  :ocean
      t.string  :coordinates

      t.timestamps
    end
    add_index :islands, :grepo_id
    add_index :islands, :island_x
    add_index :islands, :island_y
    add_index :islands, :type_number
    add_index :islands, :available_towns
    add_index :islands, :ocean
    add_index :islands, :coordinates
  end
end
