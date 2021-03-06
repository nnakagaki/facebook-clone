FacebookClone.Views.FriendRequestNum = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.collection, "sync", this.render)
  },

  template: JST["friend_request_num"],

  render: function () {
    var content = this.template({requests: this.collection});
    this.$el.html(content);
    return this;
  }
})
