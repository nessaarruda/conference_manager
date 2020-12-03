class Conference < ApplicationRecord

  def start
    start_date.strftime('%b %d, %Y')
  end

  def end
    end_date.strftime('%b %d, %Y')
  end
end
