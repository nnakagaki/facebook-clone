FacebookClone.Views.ShowUser = Backbone.View.extend({
	initialize: function (options) {
		this.listenTo(this.model, "sync", this.render)
		this.keys = {17: false, 86: false, 91: false, 93: false}
		this.youtubeReg = /(https?:\/\/www\.youtu\.?be\.com\/[^\s]+)/;
		this.youtubeReg2 = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
	},

	template: JST["show_user"],

	render: function () {
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
    filepicker.constructWidget($filePickerInput[0]);

    this.$el.find("form.upload-profile-pic button").html("");

		return this;
	},

	events: {
		"submit form#new-post": "createPost",
		"submit form#new-comment": "createComment",
		"click button.like-post": "likePost",
		"click button.unlike-post": "unlikePost",
		"click button.like-comment": "likeComment",
		"click button.unlike-comment": "unlikeComment",
		"click button.delete-post": "deletePost",
		"click button.delete-comment": "deleteComment",
		"click button.add-friend": "friendRequest",
		"click button.accept-friendship": "addFriendship",
    "focus form#new-post": "postSubmitButtonAppear",
		"keydown form#new-post": "pasteHandle",
		"keyup form#new-post": "keyCacheClear",
		"mouseeneter div.user-profile-top div.profile-pic": "profileEnter",
		"mouseleave div.user-profile-top div.profile-pic": "profileLeave",
	},

	createPost: function (event) {
		event.preventDefault();
		var values = $(event.currentTarget).serializeJSON();
		var model = new FacebookClone.Models.Post(values);

		var that = this;
		model.save({}, {
			success: function (model, res) {
				that.model.fetch();
			},
			error: function (model, res) {
				for (key in res.responseJSON) {
					$("div#errors").html(key + " " + res.responseJSON[key])
				}
			}
		});
	},

	createComment: function (event) {
		event.preventDefault();
		var values = $(event.currentTarget).serializeJSON();
		var model = new FacebookClone.Models.Comment(values);

		var that = this;
		model.save({}, {
			success: function (model, res) {
				that.model.fetch();
			},
			error: function (model, res) {
				for (key in res.responseJSON) {
					$("div#errors").html(key + " " + res.responseJSON[key])
				}
			}
		});
	},

	likePost: function (event) {
		var post_id = event.currentTarget.id;
		var model = new FacebookClone.Models.Like({post_id: post_id});

		var that = this;
		model.save({}, {
			success: function (model, res) {
				that.model.fetch();
			},
			error: function (model, res) {
				for (key in res.responseJSON) {
					$("div#errors").html(key + " " + res.responseJSON[key])
				}
			}
		});
	},

	unlikePost: function (event) {
		var id = event.currentTarget.id;
		var model = new FacebookClone.Models.Like({id: id});

		var that = this;
		model.fetch({
			success: function () {
				model.destroy({
					success: function (model, res) {
						that.model.fetch();
					},
					error: function (model, res) {
						for (key in res.responseJSON) {
							$("div#errors").html(key + " " + res.responseJSON[key])
						}
					}
				});
			}
		});
	},

	likeComment: function (event) {
		var comment_id = event.currentTarget.id;
		var model = new FacebookClone.Models.Like({comment_id: comment_id});

		var that = this;
		model.save({}, {
			success: function (model, res) {
				that.model.fetch();
			},
			error: function (model, res) {
				for (key in res.responseJSON) {
					$("div#errors").html(key + " " + res.responseJSON[key])
				}
			}
		});
	},

	unlikeComment: function (event) {
		var id = event.currentTarget.id;
		var model = new FacebookClone.Models.Like({id: id});

		var that = this;
		model.fetch({
			success: function () {
				model.destroy({
					success: function (model, res) {
						that.model.fetch();
					},
					error: function (model, res) {
						for (key in res.responseJSON) {
							$("div#errors").html(key + " " + res.responseJSON[key])
						}
					}
				});
			}
		});
	},

	deletePost: function (event) {
		var id = event.currentTarget.id;
		var model = new FacebookClone.Models.Post({id: id});

		var that = this;
		model.fetch({
			success: function () {
				model.destroy({
					success: function (model, res) {
						that.model.fetch();
					},
					error: function (model, res) {
						for (key in res.responseJSON) {
							$("div#errors").html(key + " " + res.responseJSON[key])
						}
					}
				});
			}
		});
	},

	deleteComment: function (event) {
		var id = event.currentTarget.id;
		var model = new FacebookClone.Models.Comment({id: id});

		var that = this;
		model.fetch({
			success: function () {
				model.destroy({
					success: function (model, res) {
						that.model.fetch();
					},
					error: function (model, res) {
						for (key in res.responseJSON) {
							$("div#errors").html(key + " " + res.responseJSON[key])
						}
					}
				});
			}
		});
	},

	friendRequest: function (event) {
		var requested_id = event.currentTarget.id;
		var model = new FacebookClone.Models.FriendRequest({requested_id: requested_id});

		var that = this;
		model.save({}, {
			success: function (model, res) {
				that.model.fetch();
			},
			error: function (model, res) {
				for (key in res.responseJSON) {
					$("div#errors").html(key + " " + res.responseJSON[key])
				}
			}
		});
	},

	addFriendship: function (event) {
		var requestor_id = event.currentTarget.id;
		var request_id = $(event.currentTarget).attr("request-id")
		var model = new FacebookClone.Models.Friend({requestor_id: requestor_id, request_id: request_id});

		var that = this;
		model.save({}, {
			success: function (model, res) {
				that.model.fetch();
			},
			error: function (model, res) {
				for (key in res.responseJSON) {
					$("div#errors").html(key + " " + res.responseJSON[key])
				}
			}
		});
	},

  postSubmitButtonAppear: function (event) {
    this.$el.find("form#new-post input.submit").removeClass("hidden");
  },

	pasteHandle: function (event) {
		if (event.which in this.keys) {
			this.keys[event.which] = true;
		}

		if ((this.keys[86] && this.keys[91]) || (this.keys[86] && this.keys[93])) {
			var that = this;
			$("form#new-post").one("keyup", function (event) {
				var formValue = $("form#new-post textarea").val();
				var localHostMatch = formValue.match(/(localhost)/);
				if (!localHostMatch) {
					var webMatch = formValue.match(/(https?:\/\/[^\s]+)/);
					if (webMatch) {
						var youtubeMatch = formValue.match(that.youtubeReg);
						if (youtubeMatch) {
							var youtubeMatch2 = youtubeMatch[0].match(that.youtubeReg2);
							if (youtubeMatch2 && youtubeMatch2[2].length == 11) {
								var embed = "<iframe width='470' height='276' src='//www.youtube.com/embed/"+youtubeMatch2[2]+"' frameborder='0' allowfullscreen></iframe>";
								$("form#new-post").append("<input type='hidden' name='post[embed]' value=\""+embed+"\">");
								$("form#new-post div.feed-loc").append(embed);
							}
						} else {
							$.ajax({
								url: "/api/posts/embed",
								type: "GET",
								data: {match: webMatch[0]},
								success: function (res) {
									$("form#new-post").append("<input type='hidden' name='post[embed]' value=\""+res["info"]+"\">");
									$("form#new-post div.feed-loc").append(res["info"])
								}
							});
						}
					}
				}
			});
		}
	},

	keyCacheClear: function (event) {
		for (var i in this.keys) {
			this.keys[i] = false;
		}
	},

	profileEnter: function(event) {
		$("div.user-profile-top div.profile-pic form button").addClass("darken")
	},

	profileLeave: function(event) {
		$("div.user-profile-top div.profile-pic form button").removeClass("darken")
	},
})
