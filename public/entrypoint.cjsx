# @cjsx React.DOM

_ = require('underscore')

React = require('react')
window.React = React

flux = require('../src/flux')
window.flux = flux

#setup flux
flux(window.data)

components = require('../views/components.coffee')

components.forEach (component) ->
  domElement = document.querySelector("##{component.containerId}")
  if domElement
    console.log("Found #{component.containerId}")
    React.renderComponent component({data: window.data}), domElement
  else
    console.log("No luck finding #{component.containerId}")



