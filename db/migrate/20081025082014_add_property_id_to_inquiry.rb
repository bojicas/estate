class AddPropertyIdToInquiry < ActiveRecord::Migration
  def self.up
    add_column :inquiries, :property_id, :integer
  end

  def self.down
    remove_column :inquiries, :property_id
  end
end
