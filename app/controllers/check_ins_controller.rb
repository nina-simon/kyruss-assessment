class CheckInsController < ApplicationController
  before_action :fetch_questionnaire

  def new
    @check_in = CheckIn.new
  end

  def create
    check_in = CheckIn.new(check_in_params)
    check_in.responses = process_responses(params[:check_in][:responses])

    if check_in.save!
      flash[:notice] = screening_message(check_in)
      redirect_to check_in_path(check_in)
    else
      render :new
    end
  end

  def show
    @check_in = CheckIn.find(params[:id])
  end

  def update
    CheckIn.find(params[:id])
    redirect_to new_check_in_path
  end

  private

  def fetch_questionnaire
    @questionnaire = Questionnaire.find_by(title: 'PHQ-2 Patient Depression Screening')
  end

  def check_in_params
    params.require(:check_in).permit(:patient_id, responses: {})
  end

  def process_responses(responses)
    return {} if responses.nil?

    responses.transform_values do |option_id|
      option = find_option_by_value(option_id)
      option ? option['value'] : nil
    end
  end

  def find_option_by_value(option_value)
    @questionnaire.questions.each do |question|
      option = question.options.find { |opt| opt['value'] == option_value.to_i }
      return option if option
    end
    nil
  end

  def screening_message(check_in)
    if check_in.high_score?
      "Additional screening is recommended."
    else
      "No additional screening needed."
    end
  end
end
