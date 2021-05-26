module Users::Associations
  extend ActiveSupport::Concern

  included do
    has_many :comments, dependent: :nullify
    has_many :posts, dependent: :destroy
  end
end
