FacebookClone.Views.ShowNotifications = Backbone.View.extend({
	initialize: function () {
		console.log(this.$el)
	},

	template: JST["show_notifications"],

	render: function () {
		var content = this.template();
		this.$el.html(content);

		return this
	}
})