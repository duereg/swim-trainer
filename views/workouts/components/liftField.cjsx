# @cjsx React.DOM

React = require('react')

liftField = React.createClass
  onChange: ->
    console.log("lift field #{this.props.fieldName} changed");

  lowerValue: ->
    console.log("lift field #{this.props.fieldName} lower value");

  increaseValue: ->
    console.log("lift field #{this.props.fieldName} increase value");

  render: ->
    <fieldset className='lift-field'>
      <legend>{this.props.fieldName}</legend>
      <span className="ion-ios7-plus-empty lift-field--change-value" onClick={this.increaseValue} ></span>
      <input type='text'
             className='lift-field--value'
             defaultValue={this.props.value}
             onChange={this.onChange} />
      <span className="ion-ios7-minus-empty lift-field--change-value" onClick={this.lowerValue} ></span>
    </fieldset>

module.exports = liftField
