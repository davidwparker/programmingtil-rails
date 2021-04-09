module Posts::Validations
  extend ActiveSupport::Concern

  included do
    validates :title, presence: true, allow_blank: false
    validates :content, presence: true, allow_blank: false
  end
end
