class BookingService
    def initialize(booking_params, user)
        @booking_params = booking_params
        @user = user
    end

    def create_booking
        property = Property.find(@booking_params[:property_id])

        booking = @user.bookings.build(@booking_params)
        booking.calculate_total_price

        if booking.save
            # Send confirmation email to the user
            BookingMailer.confirmation_email(booking).deliver_later

            # Notify the property owner about the new booking
            BookingMailer.new_booking_notification(booking).deliver_later

            { success: true, booking: booking }
        else
            { success: false, errors: booking.errors.full_messages }
        end
    end

    def cancel_booking(booking)
        return { success: false, errors: ['Cannot cancel a completed booking'] } if booking.completed?

        if booking.cancelled!
            # Send confirmation email to the user
            BookingMailer.cancellation_email(booking).deliver_later

            { success: true, booking: booking }
        else
            { success: false, errors: booking.errors.full_messages }
        end
    end
end