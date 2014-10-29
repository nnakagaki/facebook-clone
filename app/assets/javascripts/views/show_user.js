FacebookClone.Views.ShowUser = Backbone.View.extend({
	initialize: function (options) {
		this.listenTo(this.model, "sync", this.render)
	},

	template: JST["show_user"],

	render: function () {
		$("div#errors").html("")
		var content = this.template({
			user: this.model
		});

		this.$el.html(content);
		return this;
	},

	events: {
		"click button#notifications": "showNotifications",
		"submit form#new-post": "createPost",
		"submit form#new-comment": "createComment",
		"click button.like-post": "likePost",
		"click button.unlike-post": "unlikePost",
		"click button.like-comment": "likeComment",
		"click button.unlike-comment": "unlikeComment",
		"click button.delete-post": "deletePost",
		"click button.delete-comment": "deleteComment",
		"click button.add-friend": "friendRequest",
		"click button.accept-friendship": "addFriendship"
	},

	showNotifications: function () {
		var view = new FacebookClone.Views.ShowNotifications()
		$("body").html("hi")
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
	}
})