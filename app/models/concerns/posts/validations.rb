module Posts::Validations
  extend ActiveSupport::Concern

  included do
    validates :title, presence: true
    validates :content, presence: true
  end
end
