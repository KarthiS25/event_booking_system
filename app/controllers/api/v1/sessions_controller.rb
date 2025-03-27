# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  def create
    @user = find_user
    return invalid_email unless @user.present?
    return error_message unless @user.valid_password?(sign_in_params[:password])

    sign_in(@user, store: false)
    response_success("Logged in successfully", 200, serializer_for(resource: @user, serializer: UserSerializer))
  end

  def forgot_password
    user = User.find_by(email: params[:email])
    return invalid_email unless user.present?

    user.send_reset_password_instructions
    render json: { message: "Reset password email has been sent your email account" }, status: 200
  end

  # Need to handle JWT::DecodeError exception
  def destroy
    return logout_message if request.headers['Authorization'].nil?

    sign_out(current_user) if current_user.present?
  end

  def respond_to_on_destroy
    logout_message
  end

  def logout_message
    render json: { message: "Logged out successfully." }, status: :ok
  end

  private

  def invalid_email
    render json: { message: "Invalid email address" }, status: 422
  end

  def error_message
    render json: { message: "Invalid email address or password" }, status: 401
  end

  def sign_in_params
    params.require(:user).permit(:email, :password, :name)
  end

  def find_user
    email = sign_in_params[:email].strip.downcase
    User.find_by(email: email)
  end
end
