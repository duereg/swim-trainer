# @cjsx React.DOM

React = require('react')

formGroup = React.createClass

  propTypes: {
    inputId: React.PropTypes.string,
    label: React.PropTypes.string
  },

  render: ->
    parentClass = if this.props.className then "form-group " + this.props.className else "form-group"

    <div className={parentClass} >
      <label className="col-xs-2 control-label" htmlFor={this.props.inputId}>{this.props.label}</label>
      <div className="col-sm-10">
        {@props.children}
      </div>
    </div>

module.exports = formGroup
