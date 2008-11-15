class Inquiry < ActiveRecord::Base
  belongs_to :property
  
  apply_simple_captcha
end
