class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :neighborhood_id
      t.string :name
      t.string :url
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
