require "rails_helper"

RSpec.feature "A patient checks into the app" do
  before do
    stub_request(:get, "https://dummyjson.com/users/1").
      to_return(status: 200, body: { firstName: "John", lastName: "Doe" }.to_json, headers: { 'Content-Type' => 'application/json' })
  end
  
  scenario "for a scheduled appointment" do
    questionnaire = create(:questionnaire, title: 'PHQ-2 Patient Depression Screening')
    create(:question, questionnaire: questionnaire, text: "Little interest or pleasure in doing things?")
    create(:question, questionnaire: questionnaire, text: "Feeling down, depressed, or hopeless?")

    visit root_path

    click_on "Start check in"

    expect(page).to have_content "Welcome to your check-in"

    click_on "Start PHQ screener"

    expect(page).to have_content("Over the past 2 weeks, how often have you been bothered by any of the following problems?")
  end
end
