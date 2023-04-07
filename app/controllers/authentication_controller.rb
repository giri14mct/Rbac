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
    @user = User.active.find_by(email: params[:email])
    raise UnAuthorized unless user.present? && check_password

    user.update!(session_token: SecureRandom.hex(20), last_logged_in: Time.zone.now)
    render json: {
      status: true,
      message: 'Login Successfully..!!',
      data: user.as_json(only: %i[id session_token role])
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

  attr_accessor :user

  def singup_params
    params.require(:user).permit(:name, :email, :role).merge(
      password: Encryption::Crypter.encrypt(params[:user][:password])
    )
  end

  def validate_password?
    params[:user][:password] == params[:user][:password_confirmation]
  end

  def check_password
    params[:password] == Encryption::Crypter.decrypt(eval(user.password).deep_symbolize_keys)
  end
end
