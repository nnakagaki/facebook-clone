json.id @post.id
json.author_id @post.author_id
json.author_full_name @post.author.full_name
if @post.embed
  json.embed @post.embed
end

if @post.photo_id
  json.photo_url @post.photo.url
end

if @post.address
  json.address @post.address.split(",")[1,2]
end
if @post.author.profile_pic_mini_url
  json.author_pic @post.author.profile_pic_mini_url
else
  json.author_pic image_url('default_profile_pic.jpg')
end

json.description @post.description
json.time time_ago_in_words(@post.updated_at)

if current_user
  like_check = current_user_likes.where({likable_type: "Post", likable_id: @post.id})
  json.like_check like_check
end

json.likes @post.likes.each do |like|
  json.user_id like.user_id
  json.full_name like.user.full_name
end

json.comments @post.comments.each do |comment|
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
