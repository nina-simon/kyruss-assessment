class CheckIn < ApplicationRecord
  validates :patient_id, presence: true

  def calculate_total_score
    responses.values.compact.sum
  end

  def high_score?
    responses.values.any? { |score| score >= 2 }
  end

  def screening_message
    I18n.t(high_score? ? 'check_ins.screening_message.additional_needed' : 'check_ins.screening_message.no_additional_needed')
  end
end
