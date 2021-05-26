module Users::Validations
  extend ActiveSupport::Concern

  included do
    validates :email,
      presence: true,
      uniqueness: { case_sensitive: false }
    validates :slug,
      format: { without: /\A\d+\Z/, message: I18n.t('models.users.slug_numbers') }
    validates :username,
      presence: true,
      length: { minimum: 2 },
      uniqueness: { case_sensitive: false }
    validates :username,
      format: { with: /\A[a-zA-Z0-9_-]+\z/, message: I18n.t('models.users.username') }
    validates :username,
      format: { without: /\A\d+\Z/, message: I18n.t('models.users.username_numbers') }
  end
end
