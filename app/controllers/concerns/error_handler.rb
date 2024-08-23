module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from StandardError, with: :handle_standard_error
  end

  private

  def handle_not_found(exception)
    log_error(exception)
    redirect_to root_path, alert: I18n.t('errors.not_found')
  end

  def handle_invalid_record(exception)
    log_error(exception)
    flash.now[:alert] = exception.record.errors.full_messages.to_sentence
    render :new
  end

  def handle_parameter_missing(exception)
    log_error(exception)
    redirect_to root_path, alert: I18n.t('errors.bad_request')
  end

  def handle_standard_error(exception)
    log_error(exception)
    redirect_to root_path, alert: I18n.t('errors.unexpected_error')
  end

  def log_error(exception)
    Rails.logger.error("[#{exception.class}] #{exception.message}")
    Rails.logger.error(exception.backtrace.join("\n")) if exception.backtrace
  end
end
