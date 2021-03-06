# frozen_string_literal: true

class LocationPolicy < ApplicationPolicy
  def destroy?
    record.events.empty?
  end

  def archive?
    return false unless record.persisted?
    return false if record.archived?

    update? || edit_additional_details?
  end

  def update?
    record.events_count.zero? || user.admin? ||
      record.notable_events.map(&:organizers).flatten.map(&:id).include?(user.id)
  end

  def edit_additional_details?
    record.region&.leader?(user)
  end

  def permitted_attributes
    attributes = %i[
      name
      address_1
      address_2
      city
      state
      zip
      region_id
    ]
    if edit_additional_details?
      attributes += %i[
        contact_info
        notes
      ]
    end
    attributes
  end
end
