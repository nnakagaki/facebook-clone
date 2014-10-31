FacebookClone.Views.ShowNotifications = Backbone.View.extend({
	initialize: function () {
		this.listenTo(this.collection, "sync", this.render)
    this.listenTo(this.model, "sync", this.render)
	},

  className: "notifications",

	template: JST["show_notifications"],

  template2: JST["show_notification_number"],

	render: function () {
		var content = this.template({
		  notifications: this.collection,
      user: this.model
		});
		this.$el.html(content);

		var content2 = this.template2({
		  notifications: this.collection
		});
		$("nav div button#notifications div.not-button-place").html(content2);

		return this
	},

  events: {
    "click li.entry": "movePage"
  },

  movePage: function (event) {
    var postID = $(event.currentTarget).attr("post-id")
    var scrollFunc = function () {
      $('html, body').animate({
        scrollTop: $("li#"+postID+".post").offset().top -100
      }, 500);
      setTimeout(function () {
        $("li#"+postID+".post").addClass("notify-post");
        setTimeout(function () {
          $("li#"+postID+".post").removeClass("notify-post");
        },2000);
      }, 500);
    }

    var oneTimeCallback = _.once( function () {
      var intID = setInterval(function () {
        if ($("li#"+postID+".post")) {
          clearInterval(intID)
          scrollFunc();
        }
      }, 300);
    });

    var userPageLink = "users/" + event.currentTarget.id;
    if ("users/" + this.model.id === userPageLink) {
      scrollFunc();
    } else {
      FacebookClone.userRouter.on("route", oneTimeCallback)
      Backbone.history.navigate(userPageLink, {trigger: true});
    }
  }
})