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
						var photo = new FacebookClone.Models.Photo({ photo: { title: "Profile Pictures", url: blob.url } })
						photo.save({},{
							success: function () {
								that.fetch()
							}
						});
      		}
    		});
	  	}
		);
  },

	saveCoverPic: function (event) {

		var blob = event.fpfile;
		var that = this;

		this.set("cover_pic_url", blob.url);
		this.save({}, {
			success: function () {
				that.fetch();
				var photo = new FacebookClone.Models.Photo({ photo: { title: "Cover Photos", url: blob.url } })
				photo.save({},{
					success: function () {
						that.fetch()
					}
				});
			}
		})

		// filepicker.convert(
		// 	blob,
		// 	{
		// 		width: 837,
		// 		height: 280,
		// 		fit: "crop"
		// 	},
		// 	{location: 'S3'},
		// 	function(newBlob){
		// 		that.set("cover_pic_url", newBlob.url);
		// 		that.save({}, {
		// 			success: function () {
		// 				that.fetch()
		// 			}
		// 		});
		// 	}
		// );
	}
})
