window.FacebookClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		FacebookClone.users = new FacebookClone.Collections.Users();
		FacebookClone.users.fetch();
		new FacebookClone.Routers.User({
							$rootEl: $("div.static"),
			 				$notificationEl: $("nav div button#notifications")});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  FacebookClone.initialize();
});
