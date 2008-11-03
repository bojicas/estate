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
end
