class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  enum status: {
    inactive: 0,
    active: 1
  }

  enum role: {
    user: 0,
    admin: 1,
    super_admin: 2
  }

  before_save do
    self.role ||= :user
    self.status ||= :active
  end
end
