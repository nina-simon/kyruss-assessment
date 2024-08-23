require "rails_helper"

RSpec.feature "A patient checks into the app" do
  scenario "for a scheduled appointment" do
    visit root_path
    questionnaire = create(:questionnaire, title: 'PHQ-2 Patient Depression Screening')
    create(:question, questionnaire: questionnaire, text: "Little interest or pleasure in doing things?")
    create(:question, questionnaire: questionnaire, text: "Feeling down, depressed, or hopeless?")


    click_on "Start check in"

    expect(page).to have_content "Please complete all of the steps on this page"

    click_on "Start PHQ screener"

    expect(page).to have_content("Over the past 2 weeks, how often have you been bothered by any of the following problems?")
  end
end
