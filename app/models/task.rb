class Task < ActiveRecord::Base
  belongs_to :project
  has_many :time_tracks

  validates :project_id, presence: true
end
