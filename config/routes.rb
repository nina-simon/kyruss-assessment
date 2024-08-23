Rails.application.routes.draw do
  resources :check_ins, only: [:new, :create, :show, :update] do
    member do
      get :start_check_in
    end
  end

  root to: "check_ins#new"
end
