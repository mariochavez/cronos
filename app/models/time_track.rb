class TimeTrack < ActiveRecord::Base
  belongs_to :task

  validates :task_id, :time_in_minutes, :date, presence: true
  validates :time_in_minutes, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 1440
  }

  def time
    if self.time_in_minutes.present? && self.time_in_minutes > 0
      self.time_in_minutes / 60
    else
      0
    end
  end

  def time=(value)
    self.time_in_minutes = value * 60
  end

  scope :project_tracks, ->(project) {
    order(date: :desc).includes(task: :project)
      .where('tasks.project_id' => project.id)
  }
end
