class Property < ActiveRecord::Base
  belongs_to :building
  belongs_to :type
  has_many :inquiries

  has_one :property_photo, :dependent => :destroy

  # find related building
  def building
    building = Building.find(
      self.building_id,
      :include => [:project => [:neighborhood => :emirate]]
    )
    building
  end
  
  def find_type_name
    Type.find(self.type_id).name
  end
  
  #calculate area in square meters
  def area_in_sqm
    (self.area * 0.09290304).round
  end
end
