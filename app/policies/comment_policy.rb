class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # # Users can only create up to 3 posts
  # def create?
  #   # user.posts.size < 3
  #   true
  # end

  # # Only an user can destroy their own
  # def destroy?
  #   record.user == user
  # end

  # # Only an user can update their own
  # def update?
  #   record.user == user
  # end
end
