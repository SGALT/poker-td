class TournamentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    user_is_owner_or_admin?
  end

  def create?
    true
  end

  def update?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  def busted?
    true
  end

  def start_countdown?
    true
  end

  def pause_countdown?
    true
  end

  def reset_tournament?
    true
  end

  def copy?
    true
  end

  private

  def user_is_owner_or_admin?
    user.admin || record.user == user
  end
end
