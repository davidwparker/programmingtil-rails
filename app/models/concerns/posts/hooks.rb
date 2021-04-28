module Posts::Hooks
  extend ActiveSupport::Concern

  included do
    before_create :set_comments_cache

    def set_comments_cache
      self.comments_count = 0
    end
  end
end
