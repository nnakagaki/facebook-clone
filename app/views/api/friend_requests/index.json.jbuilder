requests = current_user.friend_requests_to_accept

json.array! requests do |request|
  json.(request, :id, :requestor_id, :requested_id)
  json.full_name request.requestor.full_name
end
