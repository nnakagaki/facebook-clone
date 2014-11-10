FacebookClone.Views.ShowUserPhotos = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.picView = {};
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
    "click div.small-picture": "showPic"
  },

  showPic: function (event) {
    var picUrl = $(event.currentTarget).css("background-image");
    $("img.picture-box").one("load", function (event) {
      var maxWidth = 360 + $("img.picture-box").width();
      if ($("img.picture-box").height() < $("img.picture-box").width()) {
        $("img.picture-box").css("width", "100%")
        $("img.picture-box").css("height", "auto")
      } else {
        $("img.picture-box").css("height", "100%")
        $("img.picture-box").css("width", "auto")
      }

      $("div.picture-modal").css("max-width", maxWidth);
    })
    $("img.picture-box").attr("src", picUrl.substring(4, picUrl.length-1))

    $("div.picture-box-box").removeClass("hidden");
    $("div.picture-modal").removeClass("hidden");
    $("div.shadow").removeClass("hidden");
    $("div.picture-modal-centering-outer").removeClass("hidden");
    $("div.picture-modal-centering-inner").removeClass("hidden");

    if (typeof this.picView.remove !== "undefined") {
      this.picView.remove();
    }
    console.log(event)
    var post = new FacebookClone.Models.Post({id: $(event.currentTarget).attr("photo-id")});
    var that = this;
    post.fetch({
      success: function (res) {
        that.picView = new FacebookClone.Views.ShowPost({model: post, user: that.model});
        $("div.picture-modal div.post-box").html(that.picView.render().$el);
      }
    });

    setTimeout(function() {
      $("div.shadow").one("click", function(event) {
        $("div.picture-modal").addClass("hidden");
        $("div.shadow").addClass("hidden");
        $("div.picture-box-box").addClass("hidden");
        $("div.picture-modal-centering-outer").addClass("hidden");
        $("div.picture-modal-centering-inner").addClass("hidden");
      });
    }, 50)
  }
})
