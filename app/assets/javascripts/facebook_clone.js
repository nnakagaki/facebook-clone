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

    var friendRequestNumView = new FacebookClone.Views.FriendRequestNum({collection: FacebookClone.friendRequest});
    $("button#friend-requests").append(friendRequestNumView.render().$el);

    $("button#friend-requests").on("click", function (event) {
      $("button#friend-requests div.main-request").toggleClass("hidden");
      setTimeout(function () {
        $(window).one("click", function (event) {
          if (event.target !== $("button#friend-requests")[0]) {
            $("button#friend-requests div.main-request").addClass("hidden");
          }
        });
      }, 100);
    })

    if (typeof notificationChannel !== "undefined") {
      notificationChannel.bind("notification",function () {
        FacebookClone.notifications.fetch();
      });
    }

    if (typeof friendshipChannel !== "undefined") {
      friendshipChannel.bind("friendship",function () {
        FacebookClone.friendRequest.fetch();
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
