module Posts::Scopes
  extend ActiveSupport::Concern

  included do
    scope :for_index, ->(params) {
      query = includes(:user).order(id: :desc)
      query = query.published if params[:published].present?
      if params[:rss].present?
        query = query.published.limit(5)
      end
      query
    }
    scope :published, ->() {
      where.not(published_at: nil)
    }
  end
end
