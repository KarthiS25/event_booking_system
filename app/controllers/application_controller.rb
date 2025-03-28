class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  respond_to :json

  def response_success(message, status, data = [], total_pages = nil, total_count = nil)
    json_response = { message: }
    json_response['data'] = data
    json_response['total_pages'] = total_pages unless total_pages.nil?
    json_response['total_count'] = total_count unless total_count.nil?
    render json: json_response, status:
  end

  def response_failure(exception, status, message = nil)
    error = if status == 500
              'Oops!, something went wrong'
            else
              message.present? ? message : exception.message
            end
    render json: { error: }, status:
  end

  # To define Common Serializer
  def serializer_for(resource:, serializer: nil, serializer_params: {})
    create_serializer_for(resource:, serializer:, serializer_type: 'hash', serializer_params:)
  end

  # To define Common Serializer
  def array_serializer_for(resource:, serializer: nil, serializer_params: {})
    create_serializer_for(resource:, serializer:, serializer_type: 'array', serializer_params:)
  end

  def create_serializer_for(resource:, serializer:, serializer_type: 'hash', serializer_params:)
    set_serializer(serializer_params, serializer, serializer_type)
    ActiveModelSerializers::SerializableResource.new(resource, serializer_params)
  end

  def set_serializer(serializer_params, serializer, serializer_type)
    return unless serializer.present?

    serializer_params[:each_serializer] = serializer if serializer_type == 'array'
    serializer_params[:serializer] = serializer if serializer_type == 'hash'
  end

  def authenticate_customer_user!
    return unauthorized_message("Your session expired. Please sign in again to continue.") unless current_user

    if current_user.organizer? || current_user.user?
      current_user
    else
      render json: { error: "You are not authorized to access." }, status: :unauthorized unless @current_user
    end
  end

  def authenticate_organize_user!
    return unauthorized_message("Your session expired. Please sign in again to continue.") unless current_user
    
    if current_user.organizer?
      current_user
    else
      render json: { error: "You are not authorized to access. Event orgaizer only access this page" }, status: :unauthorized unless @current_user
    end
  end

  def authenticate_admin_user!
    return unauthorized_message("Your session expired. Please sign in again to continue.") unless current_user
    
    if current_user.admin?
      current_user
    else
      render json: { error: "You are not authorized to access. Admin only access this page" }, status: :unauthorized unless @current_user
    end
  end

  private

  def unauthorized_message message
    render json: {
        status: 401,
        message: message,
      }, status: :unauthorized
  end
end
