module Users::Associations
  extend ActiveSupport::Concern

  included do
    has_many :posts, dependent: :destroy
  end
end
