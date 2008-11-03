class CreatePropertyPhotos < ActiveRecord::Migration
  def self.up
    create_table :property_photos do |t|
      t.integer :property_id, :parent_id, :size, :width, :height
      t.string  :content_type, :filename, :thumbnail

      t.timestamps
    end
  end

  def self.down
    drop_table :property_photos
  end
end
