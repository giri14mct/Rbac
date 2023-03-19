module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
    rescue_from InvalidParams, with: :invalid_params
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from UnAuthorized, with: :unauthorized
    rescue_from Forbidden, with: :forbidden
  end

  private

  def forbidden(_exception)
    render json: {
      status: false, message: 'Forbidden'
    }, status: :forbidden
  end

  def unauthorized
    render json: {
      status: false, message: 'Access Denied'
    }, status: :unauthorized
  end

  def not_found(exception)
    render json: {
      status: false,
      message: "#{exception.model.titleize} Not Found"
    }, status: :not_found
  end

  def invalid_params(exception)
    render json: {
      status: false,
      message: 'Invalid Data',
      data: [exception.message]
    }, status: :unprocessable_entity
  end

  def internal_server_error(_exception)
    render json: {
      status: false,
      message: 'Internal Server Error'
    }, status: :internal_server_error
  end

  def invalid_record(exception)
    render json: {
      status: false,
      message: 'Failed to save record',
      data: exception.record.error_msgs
    }, status: :unprocessable_entity
  end

  def url_not_fond
    render json: {
      status: false,
      message: 'URL Not Found'
    }, status: :not_found
  end
end
