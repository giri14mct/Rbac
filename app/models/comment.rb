class Comment < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  def created_by
    User.find(user_id).as_json(only: %i[email role])
  end

  def object_json
    as_json(only: :content, methods: :created_by)
  end

  def self.serach_data
    [all.map(&:object_json), count]
  end
end
