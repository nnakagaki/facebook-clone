json.(@user, :first_name, :last_name)

if current_user
	json.current_user_id current_user.id

	is_friend = current_user.friends_with?(@user)
	json.is_friend is_friend

	requested = current_user.requested_friendship?(@user)
	json.requested requested

	requests = current_user.friend_requests_to_accept
	json.requests requests.each do |request|
		json.request_id request.id
		json.requestor_id request.requestor.id
		json.requestor_full_name request.requestor.full_name
	end
end

is_current_user = current_user == @user
json.is_current_user is_current_user

friends = @user.friends
json.friends friends.each do |friend_id|
	json.id friend_id
	json.full_name User.find(friend_id).full_name
end

post_sort = @user.post_sort
json.post_sort post_sort.each do |post|
	json.id post.id
	json.author_id post.author_id
	json.author_full_name post.author.full_name
	json.description post.description
	json.time time_ago_in_words(post.updated_at)

	if current_user
		like_check = current_user_likes.where({likable_type: "Post", likable_id: post.id})
		json.like_check like_check
	end

	json.likes post.likes.each do |like|
		json.user_id like.user_id
		json.full_name like.user.full_name
	end

	json.comments post.comments.each do |comment|
		json.id comment.id
		json.author_id comment.author.id
		json.author_full_name comment.author.full_name
		json.description comment.description
		json.time time_ago_in_words(comment.updated_at)

		if current_user
			like_check = current_user_likes.where({likable_type: "Comment", likable_id: comment.id})
			json.like_check like_check
		end

		json.likes comment.likes.each do |like|
			json.user_id like.user_id
			json.full_name like.user.full_name
		end
	end
end