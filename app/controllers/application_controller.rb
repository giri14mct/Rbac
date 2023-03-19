class ApplicationController < ActionController::Base
  include ExceptionHandler
  skip_before_action :verify_authenticity_token
  before_action :current_user, except: %i[singup login]

  def catch_all
    url_not_fond
  end

  def index
    data, total_count = klass.search_data

    render json: {
      status: true,
      data: data,
      total_count: total_count
    }
  end

  def authorize_admin!
    return if current_user.super_admin? || current_user.admin?

    raise InvalidParams, 'You are not authorized to perform this action'
  end

  def current_user
    @current_user ||= User.find_by(session_token: auth_header)
    raise UnAuthorized unless @current_user.present?

    @current_user
  end

  def klass
    params[:controller].split('/').last.singularize.classify.constantize
  end

  def object
    @object ||= klass.find(params[:id])
  end

  private

  def auth_header
    request.headers['Authorization']
  end
end
