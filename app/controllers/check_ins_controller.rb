class CheckInsController < ApplicationController
  before_action :fetch_questionnaire, only: [:new, :create, :show, :update]
  before_action :set_check_in, only: [:show, :update]
  before_action :fetch_patient_data, only: :show

  def new
    @check_in = CheckIn.new
  end

  def create
    @check_in = CheckIn.new(check_in_params)
    @check_in.responses = CheckInResponseProcessor.new(@questionnaire, params[:check_in][:responses]).process
    
    if @check_in.save!
      flash[:notice] = @check_in.screening_message
      redirect_to check_in_path(@check_in)
    else
      render :new
    end
  end

  def show
    if @check_in.high_score?
      @remaining_questions = @questionnaire.questions.offset(2)
    end
  end

  def update
    additional_responses = params[:check_in][:responses]&.to_unsafe_h || {}

    if additional_responses.any?
      @check_in.responses.merge!(additional_responses)
      if @check_in.save
        flash[:notice] = t('check_ins.additional_responses_saved')
      else
        flash[:alert] = t('check_ins.responses_save_error')
      end
    else
      flash[:alert] = t('check_ins.no_responses_provided')
    end
  
    redirect_to new_check_in_path
  end
  

  private

  def fetch_questionnaire
    @questionnaire = Questionnaire.default
  end

  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end

  def fetch_patient_data
    patient_data = FetchPatientData.new(@check_in.patient_id).call
    @patient_name = "#{patient_data['firstName']} #{patient_data['lastName']}" if patient_data
  end

  def check_in_params
    params.require(:check_in).permit(:patient_id, responses: {})
  end
end
