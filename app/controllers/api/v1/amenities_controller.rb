class Api::V1::AmenitiesController < ApplicationController
  # GET /api/v1/amenities
  def index
    @amenities = Amenity.all

    if params[:category].present?
      @amenities = @amenities.by_category(params[:category])
    end

    render json: AmenitySerializer.new(@amenities).serializable_hash, status: :ok
  end
end