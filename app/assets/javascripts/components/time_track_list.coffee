@TimeTrackList = React.createClass(
  displayName: 'TimeTrackList'
  PropTypes: ->
    header: React.PropTypes.object
    records: React.PropTypes.array

  render_track: (value, index) ->
    tr { key: index },
      td {}, value.task_name
      td {}, value.date
      td {}, value.time

  render: ->
    tracks = @props.records.map(@render_track)

    return (
      table { className: 'pure-table pure-table-horizontal' },
        thead {},
          tr {},
            th {}, @props.header.task_name
            th {}, @props.header.date
            th {}, @props.header.time
        tbody {},
          tracks
    )
)
