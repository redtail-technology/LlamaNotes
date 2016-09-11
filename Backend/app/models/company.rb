class Company < User
  # Assocations
  has_many :notifications

  # Validations
  validates_presence_of :name
end
