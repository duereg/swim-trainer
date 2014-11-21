# @cjsx React.DOM

React = require('react')

navbar = require('./partials/navbar.cjsx')
myFooter = require('./partials/footer.cjsx')

layout = React.createClass
  render: ->
    mainContainer = this.props.containerId if this.props.containerId?

    <html>
      <head>
        <meta charSet='utf-8' />
        <meta httpEquiv='X-UA-Compatible' content='IE=edge' />
        <meta name='viewport' content='width=device-width, initial-scale=1' />
        <meta name='description', content='Swim Trainer 3000' />
        <meta name='csrf-token', content={this.props.data._csrf} />
        <meta name='author', content='Matt Blair' />
        <meta name="theme-color" content="#db5945" />
        <title>{this.props.data.title} | Swim Trainer</title>
      </head>
      <body>
        <span dangerouslySetInnerHTML={{__html: this.props.data.css('styles')}} />
        <navbar data={this.props.data} />
        <div id={mainContainer} className='container'>
          {this.props.children}
        </div>
        <myFooter />
        <script dangerouslySetInnerHTML={{
          __html: 'window.data = ' + JSON.stringify(this.props.data)
        }}>
        </script>
        <span dangerouslySetInnerHTML={{__html: this.props.data.js('application')}} />
      </body>
    </html>

module.exports = layout
