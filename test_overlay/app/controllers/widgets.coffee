`import Widget from 'appkit/models/widget'`

WidgetsController = Em.ArrayController.extend
  modelInfo: 
    store: 'widget'
    class: Widget

`export default WidgetsController`