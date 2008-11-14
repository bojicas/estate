class AddHotAvailableSoldToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :hot, :boolean, :default => false
    add_column :properties, :available, :boolean, :default => true
    add_column :properties, :sold, :boolean, :default => false
  end

  def self.down
    remove_column :properties, :sold
    remove_column :properties, :available
    remove_column :properties, :hot
  end
end
