# frozen_string_literal: true

class CoursePolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def destroy?
    record.events.empty? && user.admin?
  end

  def edit?
    update?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def permitted_attributes
    return [] unless user&.admin?

    [
      :name,
      :title,
      :description,
      {
        levels_attributes: LevelPolicy.new(user, Level).permitted_attributes + [:id]
      }
    ]
  end
end
