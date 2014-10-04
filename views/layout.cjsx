# @cjsx React.DOM

React = require('react');

# != css('styles')
        # include partials/navbar
          # include partials/flash
        # include partials/footer
        # != js('application')

layout = React.createClass
  render: ->
    console.log this.props
    <html>
      <head>
        <meta charSet='utf-8' />
        <meta httpEquiv='X-UA-Compatible' content='IE=edge' />
        <meta name='viewport' content='width=device-width, initial-scale=1' />
        <meta name='description', content='Swim Trainer 3000' />
        <meta name='csrf-token', content={this.props._csrf} />
        <meta name='author', content='Matt Blair' />
        <title>{this.props.title} | Hackathon Starter</title>
      </head>
      <body>
        <div className='container'>
          {this.props.children}
        </div>
      </body>
    </html>

module.exports = layout
