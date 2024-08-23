questionnaire = Questionnaire.create!(
  title: "PHQ-9 Patient Health Questionnaire",
  description: "A screening tool for depression, evaluating the severity of symptoms over the last 2 weeks."
)

questions = [
  "Little interest or pleasure in doing things?",
  "Feeling down, depressed, or hopeless?",
  "Trouble falling or staying asleep, or sleeping too much?",
  "Feeling tired or having little energy?",
  "Poor appetite or overeating?",
  "Feeling bad about yourself—or that you are a failure or have let yourself or your family down?",
  "Trouble concentrating on things, such as reading the newspaper or watching television?",
  "Moving or speaking so slowly that other people could have noticed? Or the opposite—being so fidgety or restless that you have been moving around a lot more than usual?",
  "Thoughts that you would be better off dead, or of hurting yourself?"
]

questions.each_with_index do |text, index|
  questionnaire.questions.create!(
    text: text,
    position: index + 1,
    options: [
      { text: "Not at all", value: 0 },
      { text: "Several days", value: 1 },
      { text: "More than half the days", value: 2 },
      { text: "Nearly every day", value: 3 }
    ]
  )
end
