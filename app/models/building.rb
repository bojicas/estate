class Building < ActiveRecord::Base
  belongs_to :project
  has_many :properties
  
  # find related project
  def project
    project = Project.find(
      project_id,
      :include => [:neighborhood => :emirate]
    )
    project
  end
end
