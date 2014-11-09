FacebookClone.Views.ShowPost = Backbone.View.extend({
  initialize: function (options) {
    this.user = options.user;
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["show_post"],

  className: "show-post",

  render: function () {
    $("div#errors").html("")
    var content = this.template({
      post: this.model,
      user: this.user
    });

    this.$el.html(content);

    var that = this;

    this.$el.find("a[href='#/users/"+this.user.id+"']").on("click", function(event) {
      console.log("refetch")
      that.user.fetch();
    });

    $("div.picture-modal form#new-comment").off();

    $("div.picture-modal form#new-comment").on("submit", function (event) {
      event.preventDefault();
      var values = $(event.currentTarget).serializeJSON();
      var model = new FacebookClone.Models.Comment(values);
      model.save({}, {
        success: function (model, res) {
          that.model.fetch();
        },
        error: function (model, res) {
          for (key in res.responseJSON) {
            $("div#errors").html(key + " " + res.responseJSON[key])
          }
        }
      });
    })

    return this;
  }
})
