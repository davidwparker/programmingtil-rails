module Comments::Logic
  extend ActiveSupport::Concern

  included do
    def self.create_comment!(user, params)
      klass = from_class_name(params.delete(:commentable_type))
      raise 'Not Commentable' if klass.blank?
      klass.find(params.delete(:commentable_id))
        .create_comment!(params.merge({ user_id: user.id}))
    end

    def self.delete_comment!(comment)
      comment.update!(
        body: '[deleted]',
        user_id: nil,
        deleted_at: Time.now,
      )
      comment
    end

    def self.update_comment!(comment, params)
      comment.update!(body: params[:body])
      comment
    end

    def self.from_class_name(klass_name)
      ret_class = nil
      Comment::CLASSES.detect do |klass|
        ret_class = klass if klass.name == klass_name
      end
      ret_class
    end
  end
end
