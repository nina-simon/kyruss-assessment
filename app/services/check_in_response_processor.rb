class CheckInResponseProcessor
  def initialize(questionnaire, responses)
    @questionnaire = questionnaire
    @responses = responses
  end

  def process
    return {} unless @responses.present?

    @responses.transform_values do |option_id|
      find_option_value(option_id)
    end.compact
  end

  private

  def find_option_value(option_value)
    @questionnaire.questions.each do |question|
      option = question.options.find { |opt| opt['value'] == option_value.to_i }
      
      return option['value'] if option
    end
    nil
  end
end
