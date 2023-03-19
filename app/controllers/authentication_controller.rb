class AuthenticationController < ApplicationController
  def singup
    raise InvalidParams, 'The password and confirmation password do not match' unless validate_password?

    User.create!(singup_params)
    render json: {
      status: true,
      message: 'User Created Successfully..!!'
    }
  end

  def login
    user = User.active.find_by(email: params[:email])
    raise UnAuthorized unless user.present? && user.password == params[:password]

    user.update!(session_token: SecureRandom.hex(20), last_logged_in: Time.zone.now)
    render json: {
      status: true,
      message: 'Login Successfully..!!',
      data: user.session_token
    }
  end

  def logout
    raise UnAuthorized unless current_user

    current_user.update!(session_token: nil)

    render json: {
      status: true,
      message: 'LoggedOut Successfully..!!'
    }
  end

  private

  def singup_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def validate_password?
    params[:user][:password] == params[:user][:password_confirmation]
  end
end
