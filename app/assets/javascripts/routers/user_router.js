FacebookClone.Routers.User = Backbone.Router.extend({
	initialize: function (options) {
		this.$rootEl = options.$rootEl
	},

  routes: {
		"users/:id": "showUser"
  },

	showUser: function (id) {
    $("nav div button#notifications").off();
    $("nav div button#notifications div.notifications").remove();

		var user = new FacebookClone.Models.User({id: id});
		user.fetch()
		var view = new FacebookClone.Views.ShowUser({
			model: user
		});

		this.$rootEl.html(view.render().$el);

		var noticeView = new FacebookClone.Views.ShowNotifications({
		  collection: FacebookClone.notifications,
      model: user
		});
		$("nav div button#notifications div.not-place").html(noticeView.render().$el);
    $("nav div button#notifications div.notifications").addClass("hidden")

		$("nav div button#notifications").on("click", function () {
      var notifications = FacebookClone.notifications.models
      for (var i = 0; i < notifications.length; i++) {
        if (!notifications[i]["seen"]) {
          notifications[i].set("seen", true)

          notifications[i].save()
        }
      }
			$("div.notifications").toggleClass("hidden")
      $("nav div button#notifications").toggleClass("clicked")
		});
	}
});