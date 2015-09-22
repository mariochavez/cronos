class TimeTracksController < ApplicationController
  include ProjectFormBuilder

  def create
    time_track = TimeTrack.new secure_params

    project = find_project
    return redirect_to project_path(project), change: ['time-tracks', 'track-form'] if time_track.save

    tracks = TimeTrack.project_tracks(project)
    @project_form = build(project, track: time_track, tracks: tracks)

    render 'projects/show', change: 'track-form'
  end

  private
  def secure_params
    params.require(:time_track).permit :date, :time_in_minutes, :task_id
  end

  def find_project
    Project.includes(:tasks).find_by id: params[:project_id].to_i
  end
end
