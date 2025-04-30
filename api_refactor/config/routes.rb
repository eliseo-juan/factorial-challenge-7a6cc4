# frozen_string_literal: true

Rails.application.routes.draw do
  resources :questions, except: %i[new edit], defaults: { format: :json } do
    member do
      post :answer
      post :rate
    end
  end

  resources :answers, only: %i[destroy update], defaults: { format: :json } do
    member do
      post :rate
    end
  end

  resources :statistics, only: :index, defaults: { format: :json }

  root to: redirect('sign_in')

  namespace :api, defaults: { format: :json } do
    namespace :v2 do
      resources :questions, except: %i[new edit] do
        member do
          resources :answers, only: %i[create destroy update]
        end
      end
      resources :answers, only: %i[create destroy update]
    end
  end
end
