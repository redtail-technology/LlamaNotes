class Webhook < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :company

  # Validations
  validates_presence_of :company_id, :user_id, :token

  after_initialize do |webhook|
    webhook.token = generate_token unless webhook.token.present?
  end

  def generate_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
