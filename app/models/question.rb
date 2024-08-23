class Question < ApplicationRecord
  belongs_to :questionnaire

  validates :options, presence: true

  def option_texts
    options.map { |option| option["text"] }
  end

  def option_values
    options.map { |option| option["value"] }
  end
end
