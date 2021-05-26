class CommentIndexSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :body,
    :updated_at

  attribute :commentable do |comment|
    {
      id: comment.commentable_id,
      type: comment.commentable_type,
      title: comment.commentable.title,
    }
  end

  attribute :user, if: Proc.new { |comment| comment.user.present? } do |comment|
    comment.user.for_others
  end
end
