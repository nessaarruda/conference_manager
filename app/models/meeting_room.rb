class MeetingRoom < ApplicationRecord
  has_many :meetings, dependent: :destroy
end
