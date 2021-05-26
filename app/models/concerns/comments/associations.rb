module Comments::Associations
  extend ActiveSupport::Concern

  included do
    belongs_to :commentable, polymorphic: true, counter_cache: true
    belongs_to :parent, class_name: 'Comment', optional: true
    belongs_to :thread, class_name: 'Comment', optional: true
    belongs_to :user, optional: true
    has_many :children, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
    has_many :descendents, class_name: 'Comment', foreign_key: :thread_id, dependent: :destroy
  end
end
