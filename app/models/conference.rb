class Conference < ApplicationRecord
  has_many :presentations, dependent: :destroy

  def self.select_conferences(params_attendees, params_sort)
    if params_sort
      select("conferences.*, count(*) AS count").left_outer_joins(:presentations).where('size >= ?', (params_attendees || 0)).group(:id).order(count: :desc, created_at: :desc)
    else
      where('size >= ?', (params_attendees || 0)).order(created_at: :desc)
    end
  end
end
