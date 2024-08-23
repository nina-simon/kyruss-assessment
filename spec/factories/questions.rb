FactoryBot.define do
    factory :question do
      text { "Default Question Text" }
      association :questionnaire
      position { 1 }
      options { [{ "text" => "Not at all", "value" => 0 }, { "text" => "Several days", "value" => 1 }] }
    end
  end
  