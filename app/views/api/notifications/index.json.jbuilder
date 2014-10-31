if current_user
  notifications = current_user.notifications

  notifications = notifications.sort { |notice1, notice2|
    notice2.updated_at <=> notice1.updated_at
  }

  json.array! notifications.each do |notification|
    json.id notification.id
    json.seen notification.seen
    json.author_full_name notification.author.full_name
    json.notifyable_type notification.notifyable_type
    json.time notification.updated_at.to_formatted_s(:short)
    json.wall notification.post.userwall_id
    json.post_id notification.post_id
  end
end