FacebookClone.Models.User = Backbone.Model.extend({
	urlRoot: "api/users",

  saveProfilePic: function (event) {

    var that = this;
    this.save({user: {profile_pic_url: event.fpfile.url}}, {
      success: function () {
        that.fetch()
      }
    })
  }
})