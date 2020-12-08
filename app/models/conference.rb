class Conference < ApplicationRecord
  has_many :presentations, dependent: :destroy

  def self.select_conferences(params_attendees, params_sort)
    if params_sort
      select("conferences.*, count(*) AS count")
      .left_outer_joins(:presentations)
      .group(:id)
      .where('size >= ?', (params_attendees || 0))
      .order(count: :desc, created_at: :desc)
    else
      where('size >= ?', (params_attendees || 0))
      .order(created_at: :desc)
    end
  end

  def name=(input)
    self[:name] = input.titleize
  end
end
