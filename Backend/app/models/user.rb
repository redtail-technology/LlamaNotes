class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :name, presence: true
  has_attached_file :icon,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  # Associations
  has_many :webhooks
  has_many :notifications

  def fetch_auth_token!
    self.update_attribute(:auth_token, SecureRandom.base64(50))
    self.auth_token
  end

  def partner?
    self.class == Company
  end

  def client?
    self.class == Client
  end
end
