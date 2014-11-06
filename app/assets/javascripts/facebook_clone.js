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

    FacebookClone.friendRequest = new FacebookClone.Collections.FriendRequests();
    FacebookClone.friendRequest.fetch();

    var friendRequestView = new FacebookClone.Views.FriendRequest({collection: FacebookClone.friendRequest});
    $("button#friend-requests").html(friendRequestView.render().$el);

    $("button#friend-requests").on("click", function (event) {
      $("button#friend-requests div").toggleClass("hidden");
    })


    if (typeof notificationChannel !== "undefined") {
      notificationChannel.bind("notification",function () {
        FacebookClone.notifications.fetch();
      });
    }

		FacebookClone.userRouter = new FacebookClone.Routers.User({
							$rootEl: $("div.static")});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  FacebookClone.initialize();
});
