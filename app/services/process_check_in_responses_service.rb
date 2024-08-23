class ProcessCheckInResponsesService
  def initialize(questionnaire, responses)
    @questionnaire = questionnaire
    @responses = responses
  end

  def call
    return {} if @responses.nil?

    @responses.transform_values do |option_id|
      option = find_option_by_value(option_id)
      option ? option['value'] : nil
    end
  end

  private

  def find_option_by_value(option_value)
    @questionnaire.questions.each do |question|
      option = question.options.find { |opt| opt['value'] == option_value.to_i }
      return option if option
    end
    nil
  end
end
