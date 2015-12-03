class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true
  validates :city,       presence: true
  validates :state,      presence: true
  validates :country,    presence: true
  validates :password,   length: { minimum: 8 }
  validates :email,      format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
  }
end
