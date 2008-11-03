class CreateProperties < ActiveRecord::Migration
  def self.up
    create_table :properties do |t|
      t.integer :building_id
      t.integer :type_id
      t.integer :bedrooms
      t.string :view
      t.integer :area
      t.integer :price
      t.string :url
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :properties
  end
end
