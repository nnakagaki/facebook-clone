FacebookClone.Views.ShowUserTop = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.currentView = "Timeline";
  },

  template: JST["show_user_top"],

  id: "user-show",

  render: function (viewOptionBool) {
    console.log(viewOptionBool)
    if (viewOptionBool !== true) {
      console.log("here")
      this.currentView = "Timeline"
    }

    $("div#errors").html("")
    var content = this.template({
      user: this.model
    });

    this.$el.html(content);

    var that = this;

    this.$el.find("a[href='#/users/"+this.model.id+"']").on("click", function(event) {
      console.log("refetch")
      that.model.fetch();
    });

    var $filePickerInput = this.$el.find("input[type=filepicker]");
    if ($filePickerInput.length !== 0) {
      filepicker.constructWidget($filePickerInput[0]);
      filepicker.constructWidget($filePickerInput[1]);
      this.$el.find("form.upload-profile-pic button").html("");
      this.$el.find("form.upload-cover-pic button").html("");
    }

    if (this.currentView === "Timeline") {
      var userView = new FacebookClone.Views.ShowUser({
        model: this.model
      });

      this.subView = userView;
    } else if (this.currentView === "About") {
      var userAboutView = new FacebookClone.Views.ShowUserAbout({
        model: this.model
      });

      this.subView = userAboutView;
    } else if (this.currentView === "Photos") {
      var userPhotosView = new FacebookClone.Views.ShowUserPhotos({
        model: this.model
      });

      this.subView = userPhotosView;
    } else if (this.currentView === "Friends") {
      var userFriendsView = new FacebookClone.Views.ShowUserFriends({
        model: this.model
      });

      this.subView = userFriendsView;
    }

    this._swapView(this.subView);

    return this;
  },

  _swapView: function (view) {
    var currentView;
    if (currentView) {
      currentView.remove();
    }

    currentView = view;
    this.$el.append(view.render().$el);
  },

  events: {
    "mouseenter div.profile-pic": "profileEnter",
    "mouseleave div.profile-pic": "profileLeave",
    "mouseenter div.cover-pic form button": "coverEnter",
    "mouseleave div.cover-pic form button": "coverLeave",
    "click ul.display-options li": "switchView"
  },

  profileEnter: function(event) {
    $("div.user-profile-top div.profile-pic form button").addClass("darken").html("<h1>Update Profile Picture</h1>")
  },

  profileLeave: function(event) {
    $("div.user-profile-top div.profile-pic form button").removeClass("darken").html("")
  },

  coverEnter: function(event) {
    $("div.user-profile-top div.cover-pic form button").addClass("darken").html("<h1>Update Cover Photo</h1>")
  },

  coverLeave: function(event) {
    $("div.user-profile-top div.cover-pic form button").removeClass("darken").html("")
  },

  switchView: function (event) {
    this.currentView = $(event.currentTarget).html();
    this.render(true);
  }
})
