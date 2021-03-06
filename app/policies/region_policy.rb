# frozen_string_literal: true

class RegionPolicy < ApplicationPolicy
  def update?
    record.leader?(user)
  end

  def modify_leadership?
    record.leader?(user)
  end

  def permitted_attributes
    [
      :name
    ]
  end
end
