json.(@user, :first_name, :last_name)

if @user.profile_pic_mini_url
	json.profile_pic_mini_url @user.profile_pic_mini_url
else
	json.profile_pic_mini_url image_url('default_profile_pic.jpg')
end

if @user.cover_pic_url
	json.cover_pic_url @user.cover_pic_url
else
	json.cover_pic_url image_url('default_cover_image.jpg')
end



if current_user
	json.current_user_id current_user.id

	if current_user.profile_pic_mini_url
		json.current_user_pic current_user.profile_pic_mini_url
	else
		json.current_user_pic image_url('default_profile_pic.jpg')
	end

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

  notifications = current_user.notifications

  notifications = notifications.sort { |notice1, notice2|
    notice2.updated_at <=> notice1.updated_at
  }

  json.notifications notifications.each do |notification|
    json.id notification.id
    json.seen notification.seen
    json.author_full_name notification.author.full_name
    json.notifyable_type notification.notifyable_type
    json.time notification.updated_at.to_formatted_s(:short)
    json.wall notification.post.userwall_id
    json.post_id notification.post_id
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

buzzfeedReg = /(https?:\/\/www\.buzzfeed\.com\/[^\s]+)/

json.post_sort post_sort.each do |post|
	json.id post.id
	json.author_id post.author_id
	json.author_full_name post.author.full_name
	if post.author.profile_pic_mini_url
		json.author_pic post.author.profile_pic_mini_url
	else
		json.author_pic image_url('default_profile_pic.jpg')
	end
	json.description post.description
	json.time time_ago_in_words(post.updated_at)

  buzzmatch = buzzfeedReg.match(post.description)
  if buzzmatch
    json.buzzfeed LinkThumbnailer.generate(buzzmatch[0])
  end

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
		if comment.author.profile_pic_mini_url
			json.author_pic comment.author.profile_pic_mini_url
		else
			json.author_pic image_url('default_profile_pic.jpg')
		end
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