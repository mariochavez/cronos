module ProjectFormBuilder
  extend ActiveSupport::Concern
  ProjectForm = Struct.new(:project, :tasks, :track, :tracks)

  def build(project, track: TimeTrack.new, tracks: [])
    tasks = project.tasks

    ProjectForm.new(project, tasks, track, tracks)
  end
end
