FacebookClone.Views.ShowUserFriends = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["show_user_friends"],

  className: "user-friends",

  render: function () {
    $("div#errors").html("")
    var content = this.template({
      user: this.model
    });

    this.$el.html(content);

    var that = this;

    this.$el.find("a[href='#/users/"+this.model.id+"']").on("click", function(event) {
      console.log("refetch")
      that.model.fetch();
    });

    return this;
  }
})
