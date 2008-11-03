class Emirate < ActiveRecord::Base
  has_many :neighborhoods
  
  validates_uniqueness_of :name
end
