class CheckIn < ApplicationRecord
  validates :patient_id, presence: true

  def calculate_total_score
    responses.values.compact.sum
  end

  def high_score?
    responses.values.any? { |score| score >= 2 }
  end
end
