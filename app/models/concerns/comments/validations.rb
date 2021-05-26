module Comments::Validations
  extend ActiveSupport::Concern

  included do
    validates :body, presence: true
    validates :commentable, presence: true
    validates :commentable_type, inclusion: { in: Comment::CLASSES.map(&:name) }
  end
end
