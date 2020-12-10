class MeetingRoom < ApplicationRecord
  has_many :meetings, dependent: :destroy

  def self.select_rooms(params_capacity, params_sort)
    if params_sort
      select("meeting_rooms.*, COUNT(*) AS count")
      .left_outer_joins(:meetings)
      .group(:id)
      .where('capacity > ?', params_capacity.to_i)
      .order(count: :desc, has_projector: :desc, created_at: :desc)
    else
      where('capacity > ?', params_capacity.to_i)
      .order(has_projector: :desc, created_at: :desc)
    end
  end
end
