class Conference < ApplicationRecord

  def start
    start_date.strftime('%b%e, %Y')
  end

  def end
    end_date.strftime('%b%e, %Y')
  end
end
