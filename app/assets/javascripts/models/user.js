FacebookClone.Models.User = Backbone.Model.extend({
	urlRoot: "api/users",

  saveProfilePic: function (event) {

  	var blob = event.fpfile;
  	var that = this;

  	this.set("profile_pic_url", blob.url);

  	filepicker.convert(
	  	blob,
	  	{
	    	width: 150,
	    	height: 150,
	    	fit: "crop"
	  	},
	  	{location: 'S3'},
	  	function(newBlob){
	    	that.set("profile_pic_mini_url", newBlob.url);
	    	that.save({}, {
      		success: function () {
        		that.fetch()
      		}
    		});
	  	}
		);
  }
})