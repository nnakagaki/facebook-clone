FacebookClone.Routers.User = Backbone.Router.extend({
	initialize: function (options) {
		this.$rootEl = options.$rootEl
	},

  routes: {
		"users/:id": "showUser"
  },

	showUser: function (id) {
		var user = new FacebookClone.Models.User({id: id});
		user.fetch()
		var view = new FacebookClone.Views.ShowUser({
			model: user
		});

		this.$rootEl.html(view.render().$el);

		var noticeView = new FacebookClone.Views.ShowNotifications();
		$("nav div button#notifications").append(noticeView.render().$el);

		$("nav div button#notifications").on("click", function () {
			$("div.notifications").toggleClass("hidden")
		});
	}
});