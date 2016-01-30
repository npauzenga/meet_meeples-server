class User < ActiveRecord::Base
  rolify
  has_secure_password

  has_many :user_group_memberships
  has_many :groups, through: :user_group_memberships

  has_many :user_game_night_attendees
  has_many :game_nights, through: :user_game_night_attendees

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
