class Comment < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  enum status: {
    drafted: 0,
    approved: 1,
    publised: 2
  }

  before_create do
    self.status ||= :drafted
  end

  def created_by
    User.find_by(user_id).as_json(only: %i[email role])
  end

  def object_json
    as_json(only: %i[id content])
  end

  def self.serach_data
    [all.map(&:object_json), count]
  end
end
