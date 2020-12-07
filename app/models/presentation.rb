class Presentation < ApplicationRecord
  belongs_to :conference

  def self.select_presentations(params_id, params_sort)
    if params_id
      where(conference_id: params_id).order(params_sort, projector_needed: :desc, created_at: :desc)
    else
      all.order(params_sort, projector_needed: :desc, created_at: :desc)
    end
  end

  def name=(input)
    self[:name] = input.titleize
  end
end
