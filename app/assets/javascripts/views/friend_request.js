FacebookClone.Views.FriendRequest = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.collection, "sync", this.render)
  },

  template: JST["friend_request"],

  className: "main-request hidden",

  render: function () {
    var content = this.template({requests: this.collection});
    this.$el.html(content);
    return this;
  },

  events: {
    "click ul li button.accept-friendship": "addFriendship"
  },

  addFriendship: function (event) {
    console.log(event)
    var requestor_id = event.currentTarget.id;
    var request_id = $(event.currentTarget).attr("request-id")
    var model = new FacebookClone.Models.Friend({requestor_id: requestor_id, request_id: request_id});

    var that = this;
    model.save({}, {
      success: function (model, res) {
        that.collection.fetch();
      },

      error: function (model, res) {
        for (key in res.responseJSON) {
          $("div#errors").html(key + " " + res.responseJSON[key])
        }
      }
    });
  },
})
