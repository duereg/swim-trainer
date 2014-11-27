# @cjsx React.DOM

React = require('react')

formGroup = React.createClass

  propTypes: {
    inputId: React.PropTypes.string,
    label: React.PropTypes.string,
    labelSize: React.PropTypes.number,
    inputSize: React.PropTypes.number
  },

  getDefaultProps: ->
    labelSize: 4
    inputSize: 8

  render: ->
    parentClass = if this.props.className then "form-group " + this.props.className else "form-group"

    <div className={parentClass} >
      <label className={"col-xs-#{this.props.labelSize} control-label"} htmlFor={this.props.inputId}>{this.props.label}</label>
      <div className={"col-sm-#{this.props.inputSize}"}>
        {@props.children}
      </div>
    </div>

module.exports = formGroup
