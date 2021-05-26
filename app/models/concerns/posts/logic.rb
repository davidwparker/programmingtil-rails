module Posts::Logic
  extend ActiveSupport::Concern

  included do
    def self.create_post!(params, user)
      post = Post.new(params.merge({
        user_id: user.id,
      }))
      post.save!
      post
    end

    def self.delete_post!(post)
      post.destroy!
      post
    end

    def self.update_post!(post, params)
      post.update!(params)
      post
    end
  end
end
