class CheckInsController < ApplicationController
  before_action :fetch_questionnaire, only: [:new, :create]
  before_action :set_check_in, only: [:show, :update]
  # before_action :fetch_patient_data, only: :new

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
  end

  def update
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
    # TODO: Need to make it dynamic
    patient_data = FetchPatientData.new('1').call
    @patient_name = "#{patient_data['firstName']} #{patient_data['lastName']}" if patient_data
  end

  def check_in_params
    params.require(:check_in).permit(:patient_id, responses: {})
  end
end
