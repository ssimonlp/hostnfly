module Api
  module V1
    class BookingsController < ApplicationController
      # GET /bookings
      def index
        @bookings = booking.all

        render json: @bookings
      end

      # GET /bookings/:id
      def show
        @booking = Booking.find(params[:id])

        render json: @booking
      end

      # POST /bookings
      def create
        @booking = Booking.new(booking_params)

        if @booking.save
          render json: @booking, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      # PUT /bookings/:id
      def update
        @booking = Booking.find(params[:id])

        if @booking
          @booking.update(booking_params)
          render json: { message: t('.successfully_updated') }, status: 200
        else
          render json: t('error'), status: 400
        end
      end

      # DELETE /bookings/:id
      def destroy
        @booking = Booking.find(params[:id])

        if @booking
          @booking.destroy
          render json: { message: t('.successfully_deleted') }, status: 200
        else
          render json: t('error'), status: 400
        end
      end

      private

        def bookings_params
          params.require(:booking).permit(
            :listing_id,
            :start_date,
            :end_date,
            :is_active
          )
        end
    end
  end
end
