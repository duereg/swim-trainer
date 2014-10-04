# @cjsx React.DOM

React = require('react');

# != css('styles')
        # include partials/navbar
          # include partials/flash
        # include partials/footer
        # != js('application')

Layout = React.createClass
  render: (data) ->
    <html>
      <head>
        <meta charset='utf-8' />
        <meta http-equiv='X-UA-Compatible', content='IE=edge' />
        <meta name='viewport', content='width=device-width, initial-scale=1.0' />
        <meta name='description', content='Swim Trainer 3000' />
        <meta name='csrf-token', content={data._csrf} />
        <meta name='author', content='Matt Blair' />
        <title>{data.title} | Hackathon Starter</title>
      </head>
      <body>
        <div className='container'>
          <block>
            {this.props.children}
          </block>
        </div>
      </body>
    </html>
