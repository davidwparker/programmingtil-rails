# == Schema Information
#
# Table name: posts
#
#  id             :bigint           not null, primary key
#  user_id        :bigint           not null
#  title          :string           not null
#  content        :text             not null
#  published_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  comments_count :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
class Post < ApplicationRecord
  include Abilities::Commentable
  include Posts::Associations
  include Posts::Hooks
  include Posts::Logic
  include Posts::Scopes
  include Posts::Validations

  extend FriendlyId
  friendly_id :title, use: [:slugged]
end
