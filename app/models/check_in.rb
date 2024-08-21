class CheckIn < ApplicationRecord
  validates :patient_id, presence: true
end
