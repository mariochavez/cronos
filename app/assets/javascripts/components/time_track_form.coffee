@TimeTrackForm = React.createClass(
  PropTypes: ->
    form_config: React.PropTypes.object
    project: React.PropTypes.object
    handle_data_change: React.PropTypes.func

  displayName: 'TimeTrackForm'

  parts:
    day: '3i'
    month: '2i'
    year: '1i'

  baseState: ->
    time_track_task: 0
    time_track_date_3i: @currentDate('day')
    time_track_date_2i: @currentDate('month')
    time_track_date_1i: @currentDate('year')
    time_track_time: 0

  componentWillReceiveProps: (new_props) ->
    return if new_props.form_config.errors.length > 0

    @setState form: @baseState()

  getInitialState: ->
    form: @baseState()

  handle_change: (evt) ->
    form = @state.form
    form[evt.target.id] = evt.target.value

    @setState form: form

  field_date_id: (part) ->
    "#{@props.form_config.resource}_date_#{@parts[part]}"

  field_date_name: (part) ->
    "#{@props.form_config.resource}[date(#{@parts[part]})]"

  render_date_options: (part) ->
    if part is 'day'
      [1..31].map (day, index) ->
        option { key: index, value: day }, day
    else if part is 'month'
      @props.form_config.fields.date.options.months.map (month, index) ->
        option { key: month.value, value: month.value }, month.display
    else if part is 'year'
      @props.form_config.fields.date.options.years.map (year, index) ->
        option { key: year.value, value: year.value }, year.display

  currentDate: (part) ->
    currentTime = new Date()
    if part is 'day'
      currentTime.getDate()
    else if part is 'month'
      currentTime.getMonth() + 1
    else if part is 'year'
      currentTime.getFullYear()

  field_id: (field) ->
    "#{@props.form_config.resource}_#{field}"

  field_name: (field) ->
    "#{@props.form_config.resource}[#{field}]"

  render_options: (field) ->
    options = @props.form_config.fields[field].options
    options.map (opt, index) ->
      option { value: opt.value, key: index }, opt.display

  render_errors: ->
    if @props.form_config.errors.length > 0
      div { className: 'error',  },
        p {}, @props.form_config.error_message
        ul {},
          @props.form_config.errors.map (value, index) ->
            li { key: index }, value
    else ''

  handle_submit: (event) ->
    event.preventDefault()

    $.ajax
      type: @props.form_config.method
      dataType: 'JSON'
      url: @props.form_config.url
      data: ($ "#new_#{@props.form_config.resource}").serialize()
      complete: (data) =>
        @props.handle_data_change data.responseJSON

  render: ->
    console.log @props
    return (
      div { id: 'track-form' },
        h3 {}, @props.form_config.name
        form {
          className: 'pure-form pure-form-stacked'
          acceptCharset: 'UTF-8'
          id: "new_#{@props.form_config.resource}"
          onSubmit: @handle_submit
          method: @props.form_config.method
          action: @props.form_config.url},
            @render_errors(),
            input { type: 'hidden', name: 'authenticity_token', defaultValue: @props.form_config.csrf_token }
            div { className: 'pure-g track-entry' },
              input { id: 'project_id', name: 'project_id', type: 'hidden', defaultValue: @props.project.id },
              div { className: 'pure-u-1-4 tasks'},
                label { htmlFor: @field_id('task') }, @props.form_config.fields.task.name
                select { id: @field_id('task'), name: @field_name('task'), value: @state.form.time_track_task, onChange: @handle_change },
                  @render_options('task'),
              div { className: 'pure-u-1-3 date'},
                label { htmlFor: @field_id('date') }, @props.form_config.fields.date.name
                select { id: @field_date_id('day'), name: @field_date_name('day'), value: @state.form.time_track_date_3i, onChange: @handle_change },
                  @render_date_options('day')
                select { id: @field_date_id('month'), name: @field_date_name('month'), value: @state.form.time_track_date_2i, onChange: @handle_change },
                  @render_date_options('month')
                select { id: @field_date_id('year'), name: @field_date_name('year'), value: @state.form.time_track_date_1i, onChange: @handle_change },
                  @render_date_options('year')
              div { className: 'pure-u-1-6 time' },
                label { htmlFor: @field_id('time') }, @props.form_config.fields.time.name
                input { id: @field_id('time'), name: @field_name('time'), value: @state.form.time_track_time, onChange: @handle_change }
              div { className: 'pure-u-1-4 action' },
                input { type: 'submit', name: 'commit', className: 'pure-button pure-button-primary', value: @props.form_config.submit }
    )
)
