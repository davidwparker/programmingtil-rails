# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  commentable_type :string
#  commentable_id   :bigint
#  user_id          :bigint
#  thread_id        :bigint
#  parent_id        :bigint
#  body             :text             not null
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_parent_id    (parent_id)
#  index_comments_on_thread_id    (thread_id)
#  index_comments_on_user_id      (user_id)
#
class Comment < ApplicationRecord
  CLASSES = [
    Post,
  ].freeze

  include Comments::Associations
  include Comments::Logic
  include Comments::Validations
end
