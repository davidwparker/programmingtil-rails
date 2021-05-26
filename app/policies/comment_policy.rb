class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  # Only an user can destroy their own
  def destroy?
    record.user == user
  end

  # Only an user can update their own
  def update?
    record.user == user
  end
end
