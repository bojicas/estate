class Neighborhood < ActiveRecord::Base
  belongs_to :emirate
  has_many :projects
  
  validates_uniqueness_of :name
  
  # find the related emirate
  def emirate
    Emirate.find(self.emirate_id)
  end
  
  def find_all_emirates
    Emirate.find(:all).map {|u| ["#{u.name}", u.id]}
  end
end
