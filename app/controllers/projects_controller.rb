class ProjectsController < ApplicationController
  include ProjectFormBuilder

  def index
    @projects = Project.all
  end

  def show
    project = find_project
    tracks = TimeTrack.project_tracks(project)

    @project_form = build(project, tracks: tracks)
  end

  private
  def find_project
    Project.includes(:tasks).find_by(id: params[:id].to_i)
  end
end
