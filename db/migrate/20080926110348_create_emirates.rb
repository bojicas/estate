class CreateEmirates < ActiveRecord::Migration
  def self.up
    create_table :emirates do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :emirates
  end
end
