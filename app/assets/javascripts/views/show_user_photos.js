FacebookClone.Views.ShowUserPhotos = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["show_user_photos"],

  className: "user-photos",

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
  },

  events: {
    "click div.small-profile-pic": "showPic"
  },

  showPic: function (event) {
    var picUrl = $(event.currentTarget).css("background-image");
    $("div.picture-modal").css("background-image", picUrl).removeClass("hidden");
    $("div.shadow").removeClass("hidden");
    setTimeout(function() {
      $("div.shadow").one("click", function(event) {
        console.log(event)
        $("div.picture-modal").addClass("hidden");
        $("div.shadow").addClass("hidden");
      });
    }, 50)
  }
})
