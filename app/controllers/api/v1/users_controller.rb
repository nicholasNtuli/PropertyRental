class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/profile
  def show
    render json: UserSerializer.new(current_user).serializable_hash, status: :ok
  end

  # PATCH /api/v1/profile
  def update
    if current_user.update(user_params)
      render json: UserSerializer.new(current_user).serializable_hash, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :bio, :avatar_url)
  end
end