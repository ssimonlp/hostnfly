module Api
  module V1
    class MissionsController < ApplicationController
      # POST /missions
      def create
        listings = Listing.all
        transaction = Missions::BulkCreateTransaction.call(resource: listings)

        if transaction.success?
          payload = compute_json_output(missions: Mission.all)

          render json: payload, status: 200
        else
          render json: { error: I18n.t('error') }, status: 400
        end
      end

      # GET /missions
      def index
        payload = compute_json_output(missions: Mission.all)

        render json: payload
      end

      private

      def compute_json_output(missions:)
        missions.map do |mission|
          attributes = { price: mission.price, type: mission.simple_type }

          JSON.parse(mission.to_json).merge(attributes)
        end
      end
    end
  end
end
