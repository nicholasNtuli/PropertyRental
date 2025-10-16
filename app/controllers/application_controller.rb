class ApplicationController < ActionController::API
    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    private 

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone])
        devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :bio, :avatar_url])
    end

    def not_found 
        render json: { error: "Not Found" }, status: :not_found
    end

    def unprocessable_entity(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
