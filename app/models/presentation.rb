class Presentation < ApplicationRecord
  belongs_to :conference

  def self.select_presentations(params)
    if params[:id]
      where(conference_id: params[:id]).order(params[:sort], projector_needed: :desc, created_at: :desc)
    else
      all.order(params[:sort], projector_needed: :desc, created_at: :desc)
    end
  end
end
