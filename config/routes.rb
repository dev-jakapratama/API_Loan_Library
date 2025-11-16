Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books
      resources :borrowers
      resources :loans do
        member do
          post :return_book
        end
        collection do
          get :active_loans
          get :overdue_loans
        end
      end
    end
  end
end