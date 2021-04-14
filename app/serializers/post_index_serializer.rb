class PostIndexSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :content,
    :published_at,
    :title

  attributes :user do |post|
    {
      displayName: post.user.display_name.presence || post.user_id,
      id: post.user_id,
      slug: post.user.slug,
    }
  end
end
