module Api
  module V1
    class ReservationsController < ApplicationController
      # GET /reservations
      def index
        @reservations = Reservation.all

        render json: @reservations
      end

      # GET /reservations/:id
      def show
        @reservation = Reservation.find(params[:id])

        render json: @reservation
      end

      # POST /reservations
      def create
        @reservation = Reservation.new(reservation_params)

        if @reservation.save
          render json: @reservation, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      # PUT /reservations/:id
      def update
        @reservation = Reservation.find(params[:id])

        if @reservation
          @reservation.update(reservation_params)
          render json: { message: t('.successfully_updated') }, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      # DELETE /reservations/:id
      def destroy
        @reservation = Reservation.find(params[:id])

        if @reservation
          @reservation.destroy
          render json: { message: t('.successfully_deleted') }, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      private

        def reservations_params
          params.require(:reservation).permit(
            :listing_id,
            :start_date,
            :end_date,
            :is_active
          )
        end
    end
  end
end
