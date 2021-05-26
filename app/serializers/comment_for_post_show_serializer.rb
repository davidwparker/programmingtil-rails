class CommentForPostShowSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :body,
    :updated_at

  attribute :user do |comment|
    comment.user.for_others
  end
end
