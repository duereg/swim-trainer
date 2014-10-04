# @cjsx React.DOM

React = require('react');

          # include partials/flash
        # include partials/footer

navbar = require('./partials/navbar.cjsx')

layout = React.createClass
  render: ->
    <html>
      <head>
        <meta charSet='utf-8' />
        <meta httpEquiv='X-UA-Compatible' content='IE=edge' />
        <meta name='viewport' content='width=device-width, initial-scale=1' />
        <meta name='description', content='Swim Trainer 3000' />
        <meta name='csrf-token', content={this.props.data._csrf} />
        <meta name='author', content='Matt Blair' />
        <title>{this.props.data.title} | Hackathon Starter</title>
      </head>
      <body>
        <span dangerouslySetInnerHTML={{__html: this.props.data.css('styles')}} />
        <navbar data={this.props.data} />
        <div className='container'>
          {this.props.children}
        </div>
        <span dangerouslySetInnerHTML={{__html: this.props.data.js('application')}} />
      </body>
    </html>

module.exports = layout
