`import Widget from 'appkit/models/widget'`

WidgetsController = Em.PaginationController.extend
  modelInfo: 
    store: 'widget'
    class: Widget

`export default WidgetsController`