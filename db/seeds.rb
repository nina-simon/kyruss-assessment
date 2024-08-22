questionnaire = Questionnaire.create!(
  title: "PHQ-2 Patient Depression Screening",
  description: "A quick screening tool for depression."
)

questionnaire.questions.create!(
  text: "Little interest or pleasure in doing things?",
  position: 1,
  options: [
    { text: "Not at all", value: 0 },
    { text: "Several days", value: 1 },
    { text: "More than half the days", value: 2 },
    { text: "Nearly every day", value: 3 }
  ]
)

questionnaire.questions.create!(
  text: "Feeling down, depressed, or hopeless?",
  position: 2,
  options: [
    { text: "Not at all", value: 0 },
    { text: "Several days", value: 1 },
    { text: "More than half the days", value: 2 },
    { text: "Nearly every day", value: 3 }
  ]
)
