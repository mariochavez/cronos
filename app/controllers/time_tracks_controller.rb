class TimeTracksController < ApplicationController
  include ProjectFormBuilder

  def create
    time_track = TimeTrack.new date: parse_date, time_in_minutes: parse_time,
      task: find_task

    project = find_project
    if time_track.save
      return redirect_to project_path(project) unless request.xhr?
    end

    tracks = TimeTrack.project_tracks(project)
    @project_form = build(project, track: time_track, tracks: tracks)

    if request.xhr?
      return render json: @project_form, status: time_track.valid? ? :ok : :unprocessable_entity
    end

    render 'projects/show'
  end

  private
  def find_project
    Project.includes(:tasks).find_by id: params[:project_id].to_i
  end

  def find_task
    Task.find_by id: params[:time_track][:task].to_i
  end

  def parse_time
    time = params[:time_track][:time]
    time_number = time.to_f

    return time_number if time.downcase.end_with?('m')

    time_number * 60.0
  end

  def parse_date
    begin
      Time.zone.parse "#{params[:time_track]['date(1i)']}-#{params[:time_track]['date(2i)']}-#{params[:time_track]['date(3i)']}"
    rescue
      nil
    end
  end
end
