class Building < ActiveRecord::Base
  belongs_to :project
  has_many :properties
  
  validates_presence_of :project_id, :name
  validates_numericality_of :project_id
  
  # find related project
  def project
    project = Project.find(
      project_id,
      :include => [:neighborhood => :emirate]
    )
    project
  end
  
  def find_all_projects(neighborhood_id = nil)
    if neighborhood_id
      Project.find(:all, :conditions => ["neighborhood_id = ?", neighborhood_id]).map {|u| ["#{u.name}", u.id]}
    else
      Project.find(:all).map {|u| ["#{u.name}", u.id]}
    end
  end
end
