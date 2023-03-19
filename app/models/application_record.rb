class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def error_msgs
    errors.full_messages
  end
end
