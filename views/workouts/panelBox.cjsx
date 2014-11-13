# @cjsx React.DOM

React = require('react')

panelBox = React.createClass
  render: ->
    panelHeader = <div className="panel-heading"><h3 className="panel-title">{this.props.title}</h3></div>
    panelFooter = <div className="panel-footer panel-footer-simple">{this.props.footer}</div>

    <div className="panel panel-default">
      { if this.props.title?.length then panelHeader else '' }
      <div className="panel-body">
        <div className="row">
          {this.props.children}
        </div>
      </div>
      { if this.props.footer?.length then panelFooter else '' }
    </div>

module.exports = panelBox
