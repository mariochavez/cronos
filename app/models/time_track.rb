class TimeTrack < ActiveRecord::Base
  attribute :time_in_minutes, :time_to_minutes

  belongs_to :task

  validates :task_id, :time_in_minutes, :date, presence: true
  validates :time_in_minutes, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 1440
  }

  scope :project_tracks, ->(project) {
    order(date: :desc).order(id: :desc)
      .includes(task: :project)
      .where('tasks.project_id' => project.id)
  }
end
