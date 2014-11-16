# @cjsx React.DOM

React = require('react')

buttonGroup = React.createClass
  render: ->
    <div className="btn-group btn-group-xs" data-toggle="buttons" role="group" aria-label={this.props.groupName}>
      {
        props = this.props
        props.items.map (item, index) ->
          <label key={if props.valueField then item[props.valueField] else item} className="btn btn-primary">
            <input type="radio" name={props.groupName} id={index} value={ if props.valueField then item[props.valueField] else item} />
            {if props.nameField then item[props.nameField] else item}
          </label>
      }
    </div>

module.exports = buttonGroup
