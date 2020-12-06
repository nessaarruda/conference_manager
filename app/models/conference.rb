class Conference < ApplicationRecord
  has_many :presentations, dependent: :destroy
end
