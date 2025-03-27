# frozen_string_literal: true

class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    User.transaction do
      @user = User.new(email: sign_up_params[:email])
      if @user.update(sign_up_params)
        UserMailer.welcome_email(@user).deliver_later
        sign_in(@user, store: false)
        response_success("Sign up successfully", 200, serializer_for(resource: @user, serializer: UserSerializer))
      else
        response_failure("", 422, @user.errors.full_messages[0])
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :phone_number,
                                 :age, :address).merge(role: :user)
  end
end
