class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :featured, :search]
  before_action :set_property, only: [:show, :update, :destroy, :upload_photos]
  before_action :authorize_owner!, only: [:update, :destroy, :upload_photos]

  # GET /api/v1/properties
  def index
    @properties = Property.includes(:photos, :amenities, :user)
                         .active_properties
                         .page(params[:page])
                         .per(20)

    render json: PropertySerializer.new(@properties, params: { include_user: true }).serializable_hash, status: :ok
  end

  # GET /api/v1/properties/:id
  def show
    render json: PropertySerializer.new(@property, params: { detailed: true }).serializable_hash, status: :ok
  end

  # GET /api/v1/properties/featured
  def featured
    @properties = Property.includes(:photos)
                         .featured_properties
                         .limit(10)

    render json: PropertySerializer.new(@properties).serializable_hash, status: :ok
  end

  # GET /api/v1/properties/search
  def search
    @q = Property.ransack(params[:q])
    @properties = @q.result(distinct: true)
                    .includes(:photos, :amenities)
                    .active_properties
                    .page(params[:page])
                    .per(20)

    render json: PropertySerializer.new(@properties).serializable_hash, status: :ok
  end

  # POST /api/v1/properties
  def create
    @property = current_user.properties.build(property_params)

    if @property.save
      render json: PropertySerializer.new(@property).serializable_hash, status: :created
    else
      render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/properties/:id
  def update
    if @property.update(property_params)
      render json: PropertySerializer.new(@property).serializable_hash, status: :ok
    else
      render json: { errors: @property.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/properties/:id
  def destroy
    @property.destroy
    head :no_content
  end

  # POST /api/v1/properties/:id/upload_photos
  def upload_photos
    uploaded_photos = []

    params[:photos].each_with_index do |photo, index|
      result = CloudinaryService.upload(photo.tempfile)
      
      uploaded_photo = @property.photos.create!(
        cloudinary_id: result['public_id'],
        url: result['secure_url'],
        position: @property.photos.count + index,
        is_primary: @property.photos.empty? && index.zero?
      )
      
      uploaded_photos << uploaded_photo
    end

    render json: PhotoSerializer.new(uploaded_photos).serializable_hash, status: :created
  end

  # GET /api/v1/my_properties
  def my_properties
    @properties = current_user.properties
                             .includes(:photos, :bookings)
                             .page(params[:page])
                             .per(20)

    render json: PropertySerializer.new(@properties).serializable_hash, status: :ok
  end

  private

  def set_property
    @property = Property.includes(:photos, :amenities, :reviews, :user).find(params[:id])
  end

  def authorize_owner!
    unless @property.user_id == current_user.id || current_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def property_params
    params.require(:property).permit(
      :title, :description, :location, :city, :country,
      :latitude, :longitude, :price_per_night, :property_type,
      :bedrooms, :bathrooms, :guests, :status, :featured,
      amenity_ids: []
    )
  end
end