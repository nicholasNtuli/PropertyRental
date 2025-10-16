class SearchService
    def initialize(params)
        @params = params
    end

    def call
        properties = Property.active_properties.includes(:photos, :amenities)

        properties = filter_by_location(properties)
        properties = filter_by_price(properties)
        properties = filter_by_guests(properties)
        properties = filter_by_property_type(properties)
        properties = filter_by_amenities(properties)
        properties = filter_by_availability(properties)
        properties = sort_results(properties)

        properties.page(@params[:page]).per(20)
    end

    private

    def filter_by_location(properties)
        return properties unless @params[:location].present?
        properties.where('LOWER(city) LIKE ?', "%#{@params[:location].downcase}%")
    end

    def filter_by_price(properties)
        properties.where('price_per_night >= ?', @params[:min_price]) if @params[:min_price].present?
        properties.where('price_per_night <= ?', @params[:max_price]) if @params[:max_price].present?
        properties
    end

    def filter_by_guests(properties)
        return properties unless @params[:guests].present?
        properties.where('guests >= ?', @params[:guests])
    end

    def filter_by_property_type(properties)
        return properties unless @params[:property_type].present?
        properties.where(property_type: @params[:property_type])
    end

    def filter_by_amenities(properties)
        return properties unless @params[:amenities].present?

        amenities_ids = @params[:amenities].map(&:to_i)
        properties.joins(:amenities)
                  .where(amenities: { id: amenities_ids })    
                  .group('properties.id')
                  .having('COUNT(DISTINCT amenities.id) = ?', amenities_ids.size)
    end

    def filter_by_availability(properties)
        return properties unless @params[:check_in].present? && @params[:check_out].present?

        check_in = Date.parse(@params[:check_in]) rescue nil
        check_out = Date.parse(@params[:check_out]) rescue nil
        
        properties.where.not(
            id: Booking.where(status: ['confirmed', 'pending'])
                       .where('check_in < ? AND check_out > ?', check_out, check_in)
                       .select(:property_id)
        )
    end

    def sort_results(properties)
        case @params[:sort_by]
        when 'price_low'
            properties.order(price_per_night: :asc)
        when 'price_high'
            properties.order(price_per_night: :desc)
        when 'rating'
            properties.order(average_rating: :desc)
        when 'newest'
            properties.order(created_at: :desc)
        else
            properties.order(featured: :desc, average_rating: :desc)
        end
    end
end