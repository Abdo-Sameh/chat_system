Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :applications, param: :token, only: [:index, :create, :update, :show] do
        resources :chats, param: :number, only: [:index, :create, :update, :show] do
          get 'search', to: 'chats#search', on: :member
          resources :messages, param: :number, only: [:index, :create, :update, :show]
        end
      end
    end
  end
end
