class Questionnaire < ApplicationRecord
    has_many :questions, dependent: :destroy

    scope :default, -> { first }
end
