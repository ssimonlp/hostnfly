# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :listings
      resources :bookings
      resources :reservations
      resources :missions, only: %i[index create]
    end
  end
end
