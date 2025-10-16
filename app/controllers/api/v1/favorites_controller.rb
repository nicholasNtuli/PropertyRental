class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_user!

  # GET /api/v1/favorites
  def index
    @favorites = current_user.favorites
                            .includes(property: :photos)
                            .order(created_at: :desc)

    render json: FavoriteSerializer.new(@favorites).serializable_hash, status: :ok
  end

  # POST /api/v1/favorites
  def create
    @favorite = current_user.favorites.build(property_id: params[:property_id])

    if @favorite.save
      render json: FavoriteSerializer.new(@favorite).serializable_hash, status: :created
    else
      render json: { errors: @favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/favorites/:id
  def destroy
    @favorite = current_user.favorites.find_by(property_id: params[:id])
    
    if @favorite
      @favorite.destroy
      head :no_content
    else
      render json: { error: 'Favorite not found' }, status: :not_found
    end
  end
end