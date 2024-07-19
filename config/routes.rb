Rails.application.routes.draw do
  resources :employees, only: [:index] do
    collection do
      get "fetch"
    end
  end

  root "employees#index"
end
