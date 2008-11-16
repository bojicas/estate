class PropertyPhoto < ActiveRecord::Base
  belongs_to :property
  
  has_attachment  :content_type => :image,
                  :storage      => :file_system,
                  :max_size     => 750.kilobytes,
                  :resize_to    => '800x600>',
                  :thumbnails   => {
                    :large  => '320x240>',
                    :medium => '130x86>',
                    :small  => '80x60>',
                  }
                  
  validates_as_attachment
end
