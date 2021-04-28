class PostShowSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :comments_count,
    :content,
    :published_at,
    :title

  #
  # Show the most recent 5 comments with the users
  #
  attribute :comments do |post|
    comments = post.comments.includes(:user).order(id: :desc).limit(5)
    CommentForPostShowSerializer.new(comments, { is_collection: true })
  end

  attribute :user do |post|
    {
      displayName: post.user.display_name.presence || post.user_id,
      id: post.user_id,
      slug: post.user.slug,
    }
  end
end
