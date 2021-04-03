class PostShowSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :camel_lower

  attributes :id,
    :content,
    :published_at,
    :title,
    :user_id
end
