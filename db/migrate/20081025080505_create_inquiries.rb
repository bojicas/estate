class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.text :message
      t.string :status, :limit => 15

      t.timestamps
    end
  end

  def self.down
    drop_table :inquiries
  end
end
