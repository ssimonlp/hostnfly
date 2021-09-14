# spec/controllers/api/v1/recipes_controller_spec.rb

require 'rails_helper'
RSpec.describe Api::V1::MissionsController, type: :controller do
  describe 'GET #index' do
    let(:listing) { create(:complete_listing) }

    before do
      create_list(:first_checkin_mission, 5, listing_id: listing.id)
      create_list(:last_checkout_mission, 5, listing_id: listing.id)
      create_list(:checkout_checkin_mission, 5, listing_id: listing.id)
      get :index
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected mission attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response.first.keys).to match_array(
        %w[
          id
          date
          created_at
          updated_at
          listing_id
          price
          type
        ]
      )
    end
  end

  describe 'POST #create' do
    before do
      create_list(:complete_listing, 5)
      post :create
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'JSON body response contains expected mission attributes' do
      json_response = JSON.parse(response.body)
      expect(json_response.first.keys).to match_array(
        %w[
          id
          date
          created_at
          updated_at
          listing_id
          price
          type
        ]
      )
    end
  end
end
