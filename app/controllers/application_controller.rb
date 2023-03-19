class ApplicationController < ActionController::Base
  include ExceptionHandler
  skip_before_action :verify_authenticity_token
  before_action :current_user, except: %i[singup login]

  def authorize_super_admin!
    raise UnAuthorized, 'You are not authorized to perform this action' unless current_user.super_admin?
  end

  def current_user
    @current_user ||= User.find_by(session_token: auth_header)
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
