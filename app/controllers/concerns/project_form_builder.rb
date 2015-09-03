module ProjectFormBuilder
  extend ActiveSupport::Concern
  ProjectForm = Struct.new(:project, :tasks, :track, :tracks,
                           :track_list_header, :form_config)

  def build(project, track: TimeTrack.new, tracks: [])
    tasks = project.tasks
    track_list_header = {
      task_name: I18n.t('projects.tracks_list.table.task'),
      date: I18n.t('projects.tracks_list.table.date'),
      time: I18n.t('projects.tracks_list.table.time')
    }

    form_config = {
      name: I18n.t('projects.time_track_form.track_time'),
      url: time_tracks_path,
      method: 'post',
      csrf_token: form_authenticity_token,
      errors: track.errors.full_messages,
      error_message: I18n.t('projects.time_track_form.form-error'),
      resource: 'time_track',
      submit: I18n.t('helpers.submit.create', model: I18n.t('activerecord.models.time_track')),
      fields: {
        task: {
          name: I18n.t('activerecord.attributes.time_track.task_id'),
          options: [ { value: '',
                       display: I18n.t('helpers.select.prompt') } ] + tasks.map{ |task| { value: task.id, display: task.name } }
        },
        date: {
          name: I18n.t('activerecord.attributes.time_track.date'),
          options: {
            months: I18n.t('date.month_names').compact.map.with_index{ |month, index| { value: index + 1, display: month } },
            years: ((Date.today.year - 5)..(Date.today.year + 5)).map{ |year| { value: year, display: year } }
          }
        },
        time: {
          name: I18n.t('activerecord.attributes.time_track.time')
        }
      }
    }

    ProjectForm.new(project, tasks, track, tracks, track_list_header,
                    form_config)
  end
end
