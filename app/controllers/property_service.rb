class PropertyService
  
  attr_reader :property, :property_photo
  
  def initialize(property, property_photo)
    @property = property
    @property_photo = property_photo
  end
  
  def save
    return false unless valid?
    begin
      Property.transaction do
        if @property_photo.new_record?
          # use plural in case of relation :property has_many :property_photos
          @property.property_photo.destroy if @property.property_photo
          # in case of many to one fetch all photos anf call for each instance property_photo.save
          @property_photo.property = @property
          @property_photo.save!
        end
        @property.save!
        true
      end
    rescue
      false
    end
  end
  
  def update_attributes(property_attributes, property_photo_file)
    @property.attributes = property_attributes
    unless property_photo_file.blank?
      @property_photo = PropertyPhoto.new(:uploaded_data => property_photo_file)
    end
    save
  end
  
  def valid?
    @property.valid? && @property_photo.valid?
  end
end

