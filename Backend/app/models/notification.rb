class Notification < ApplicationRecord
  # Assocations
  belongs_to :company
  belongs_to :user

  # Validations
  validates_presence_of :message, :company_id, :user_id

  def icon_url
    company.icon.url
  end

  def company_name
    company.name
  end

  def hour_created_at
    created_at.in_time_zone("Mountain Time (US & Canada)").strftime('%l:%M%p')
  end
end
