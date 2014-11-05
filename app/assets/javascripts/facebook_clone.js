window.FacebookClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		FacebookClone.users = new FacebookClone.Collections.Users();
		FacebookClone.users.fetch();
    FacebookClone.notifications = new FacebookClone.Collections.Notifications();
    FacebookClone.notifications.fetch();

    notificationChannel.bind("notification",function () {FacebookClone.notifications.fetch()})

		FacebookClone.userRouter = new FacebookClone.Routers.User({
							$rootEl: $("div.static")});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  FacebookClone.initialize();
});
