class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :comments
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

  def object_json
    as_json(
      except: %i[password session_token created_at updated_at]
    )
  end

  def self.serach_data
    [all.map(&:object_json), count]
  end
end
