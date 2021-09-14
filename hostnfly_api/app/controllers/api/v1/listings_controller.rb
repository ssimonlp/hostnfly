module Api
  module V1
    class ListingsController < ApplicationController
      # GET /listings
      def index
        @listings = Listing.all

        render json: @listings
      end

      # GET /listings/:id
      def show
        @listing = Listing.find(params[:id])

        render json: @listing
      end

      # POST /listings
      def create
        @listing = Listing.new(listing_params)

        if @listing.save
          render json: @listing, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      # PUT /listings/:id
      def update
        @listing = Listing.find(params[:id])

        if @listing
          @listing.update(listing_params)
          render json: { message: t('.successfully_updated') }, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      # DELETE /listings/:id
      def destroy
        @listing = Listing.find(params[:id])

        if @listing
          @listing.destroy
          render json: { message: t('.successfully_deleted') }, status: 200
        else
          render json: { error: t('error') }, status: 400
        end
      end

      private

        def listings_params
          params.require(:listing).permit(:num_rooms)
        end
    end
  end
end
