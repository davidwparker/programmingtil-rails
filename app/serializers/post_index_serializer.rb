class PostIndexSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :comments_count,
    :content,
    :published_at,
    :slug,
    :title

  attribute :user do |post|
    post.user.for_others
  end
end
