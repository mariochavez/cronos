@TimeTrack = React.createClass(
  displayName: 'TimeTrack'
  propTypes: ->
    form: React.PropTypes.object

  getInitialState: ->
    form: @props.form
    token: @props.token

  handle_data_change: (data) ->
    @setState form: data

  render: ->
    return (
      div {},
        React.createElement TimeTrackForm,
          form_config: @state.form.form_config
          project: @state.form.project
          handle_data_change: @handle_data_change

        React.createElement TimeTrackList,
          header: @state.form.track_list_header
          records: @state.form.tracks
    )
)
