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
    User.find_by(id: user_id).as_json(only: %i[email role])
  end

  def approved_person
    User.find_by(id: approved_by).as_json(only: %i[email role])
  end

  def object_json
    as_json(
      only: %i[id content status],
      methods: %i[created_by approved_person]
    )
  end

  def self.search_data(status: false)
    comment_status = status || statuses.keys
    data = where(status: comment_status)
    [
      data.map(&:object_json),
      data.count
    ]
  end
end
