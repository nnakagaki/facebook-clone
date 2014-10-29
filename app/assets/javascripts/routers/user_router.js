FacebookClone.Routers.User = Backbone.Router.extend({
	initialize: function (options) {
		this.$rootEl = options.$rootEl
		this.$notificationEl = options.$notificationEl
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

		this.$rootEl.html(view.render().$el)
	}
});