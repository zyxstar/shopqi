App.Controllers.LinkLists = Backbone.Controller.extend
  routes:
    "link_lists/:id/edit":           "edit"
    "":                         "index"
    "new":                      "newOne"

  edit: (id) ->
    model = new LinkList(id: id)
    model.fetch
      success: (model, resp) ->
        new App.Views.LinkList.Edit(model: model)
      #therubyracer bug https://github.com/cowboyd/therubyracer/issues/61#comment_807995
      #error: () ->
      #  new Error(message: '找不到相应的记录.')
      #  window.location.hash = '#'

  index: () ->
    $.getJSON '/admin/link_lists', (data) ->
      if data
        link_lists = _(data).map (i) ->
          return new LinkList(i)
        new App.Views.LinkList.Index(link_lists: link_lists)
      #else
      #  new Error(message: "加载记录时发生错误.")

  newOne: () ->
    new App.Views.LinkList.New