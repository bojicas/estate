class Project < ActiveRecord::Base
  belongs_to :neighborhood
  has_many :buildings

  # find related neighborhood
  def neighborhood
    neighborhood = Neighborhood.find(
      neighborhood_id,
      :include => :emirate
    )
    neighborhood
  end
  
  def find_all_neighborhoods(emirate_id = nil)
    if emirate_id
      Neighborhood.find(:all, :conditions => ["emirate_id = ?", emirate_id]).map {|u| ["#{u.name}", u.id]}
    else
      Neighborhood.find(:all).map {|u| ["#{u.name}", u.id]}
    end
  end
end
