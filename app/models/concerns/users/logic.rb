module Users::Logic
  extend ActiveSupport::Concern

  included do
    def for_display
      {
        displayName: display_name,
        email: email,
        id: id,
        username: username,
      }
    end

    def for_others
      {
        displayName: display_name.presence || id,
        id: id,
        slug: slug,
      }
    end
  end
end
