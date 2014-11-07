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
    FacebookClone.currentUser = user;

		var userViewTop = new FacebookClone.Views.ShowUserTop({
			model: user
		});

		notificationChannel.unbind("notification",function () {
			user.fetch()
		});

		notificationChannel.bind("notification",function () {
			user.fetch()
		});

		var notView = new FacebookClone.Views.ShowNotifications({
		  collection: FacebookClone.notifications,
      model: user
		});

    this._swapView(userViewTop, notView)

    $("a[href='#/users/"+user.id+"']").on("click", function(event) {
      console.log("refetch")
      user.fetch();
    });

    $("nav div button#notifications div.notifications").addClass("hidden")

		$("nav div button#notifications").on("click", function () {
			if (event.target === $("nav div button#notifications")[0]) {
	      var notifications = FacebookClone.notifications.models
	      for (var i = 0; i < notifications.length; i++) {
	        if (!notifications[i]["seen"]) {
	          notifications[i].set("seen", true)

	          notifications[i].save()
	        }
	      }
				$("div.notifications").toggleClass("hidden")
	      $("nav div button#notifications").toggleClass("clicked")

				setTimeout(function () {
					$(window).one("click", function (event) {
						if (event.target !== $("nav div button#notifications")[0]) {
							$("div.notifications").addClass("hidden");
							$("nav div button#notifications").removeClass("clicked");
						}
					});
				}, 100);
			}
		});
	},

  _swapView: function (userViewTop, notView) {
    var currentUserViewTop, currentNotView;
    if (currentUserViewTop && currentNotView) {
      currentUserViewTop.remove();
			currentUserViewTop.subView.remove();
      currentNotView.remove();
    }

		currentUserViewTop = userViewTop;
    currentNotView = notView;
		this.$rootEl.html(userViewTop.render().$el);
    $("nav div button#notifications div.not-place").html(notView.render().$el);
  }
});
