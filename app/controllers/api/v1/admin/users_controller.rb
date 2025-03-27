# frozen_string_literal: true

class Api::V1::Admin::UsersController < ApplicationController
  before_action :authenticate_admin_user!
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.organizers

    response_success("User list", 200, array_serializer_for(resource: @users, serializer: UserSerializer))
  end

  def show
    response_success("User details", 200, serializer_for(resource: @user, serializer: UserSerializer))
  end

  def create
    @user = User.create(user_params)
    return error_message if @user.errors.any?

    UserMailer.welcome_email(@user).deliver_later
    response_success("User created successfully", 200, serializer_for(resource: @user, serializer: UserSerializer))
  end

  def update
    return error_message unless @user.update(user_params)

    response_success("User updated successfully", 200, serializer_for(resource: @user, serializer: UserSerializer))
  end

  def destroy
    return error_message unless @user.destroy

    response_success("User deleted successfully", 200, nil)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :phone_number, :age, :address)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    return response_failure("", 422, "User not found") unless !@user.admin? && @user
  end

  def error_message
    response_failure("", 422, @user.errors.full_messages[0])
  end

  def authenticate_admin_user!
    unless current_user&.admin?
      render json: { message: "You are not authorized access" }, status: :unauthorized
      return
    end
  end
end
