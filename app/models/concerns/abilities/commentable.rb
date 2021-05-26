module Abilities::Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable

    def create_comment!(params)
      comment = comments.build(params)
      save
      comment
    end
  end
end
