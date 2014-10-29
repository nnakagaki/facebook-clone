window.FacebookClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Backbone.history.start();
  }
};

$(document).ready(function(){
  FacebookClone.initialize();
});
