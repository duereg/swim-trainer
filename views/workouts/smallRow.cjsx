# @cjsx React.DOM

React = require('react')

smallRow = React.createClass
  render: ->
    <div className='row'>
      <div className='col-xs-12'>
        {this.props.children}
      </div>
    </div>

module.exports = smallRow
