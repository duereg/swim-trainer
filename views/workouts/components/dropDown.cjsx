# @cjsx React.DOM

React = require('react')

dropDown = React.createClass
  selectedValue: ->

  render: ->
    <div className="btn-group" role="group" aria-expanded="false">
      <button type="button" className="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
        { this.props.label }
        <span className="caret"></span>
      </button>
      <ul className="dropdown-menu" role="menu">
        {
          props = this.props
          props.items.map (item, index) ->
            <li key={if props.valueField then item[props.valueField] else item}>
              <a href="#">
                {if props.nameField then item[props.nameField] else item}
              </a>
            </li>
        }
      </ul>
    </div>

module.exports = dropDown
