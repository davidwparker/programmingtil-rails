module Abilities::Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable

    def add_comment(params)
      comment = comments.build(params)
      save
      comment
    end
  end
end
