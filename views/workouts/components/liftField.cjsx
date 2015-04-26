# @cjsx React.DOM

React = require('react')

liftField = React.createClass
  render: ->
    <fieldset className='lift-field'>
      <legend>{this.props.fieldName}</legend>
      <span class="ion-ios7-plus-empty lift-field--change-value"></span>
      <input type='text' style='lift-field--value' />
      <span class="ion-ios7-minus-empty lift-field--change-value"></span>
    </fieldset>

module.exports = liftField
