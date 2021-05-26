class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    attr_reader :user, :scope, :params

    def initialize(user, scope)
      @user = user&.user
      @params = user&.params
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
