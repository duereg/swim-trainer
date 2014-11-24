# @cjsx React.DOM

React = require('react/addons')
classSet = React.addons.classSet

buttonGroup = React.createClass

  propTypes: {
    justified: React.PropTypes.bool,
    valueField: React.PropTypes.string,
    nameField: React.PropTypes.string,
    groupName: React.PropTypes.string
  },

  render: ->

    classes = classSet
      'btn-group': true
      'btn-group-xs': true
      'btn-group-justified': this.props.justified

    <div className={classes} data-toggle="buttons" role="group" aria-label={this.props.groupName}>
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
