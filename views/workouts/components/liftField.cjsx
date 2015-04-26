# @cjsx React.DOM

React = require('react')

liftField = React.createClass
  render: ->
    <fieldset className='lift-field'>
      <legend>{this.props.fieldName}</legend>
      <span className="ion-ios7-plus-empty lift-field--change-value"></span>
      <input type='text' className='lift-field--value' value={this.props.value} />
      <span className="ion-ios7-minus-empty lift-field--change-value"></span>
    </fieldset>

module.exports = liftField
