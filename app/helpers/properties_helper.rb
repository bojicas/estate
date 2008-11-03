module PropertiesHelper
  def property_photo_for(property, size = :medium, html_class = "left")
    if property.property_photo
      property_image = property.property_photo.public_filename(size)
      # link_to image_tag(property_image, :class => html_class), property.property_photo.public_filename, :class => html_class
      image_tag(property_image, :class => html_class)
    else
      image_tag("/images/blank_cover_#{size}.png", :class => html_class)
    end
  end
end
