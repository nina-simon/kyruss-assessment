FactoryBot.define do
  factory :check_in do
    patient_id { "1" }
    responses {
      {"1" => 1}
    }
  end
end
