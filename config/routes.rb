Rails.application.routes.draw do

  devise_for :users
  resources :jobs do
    get '/assignjob',to: "jobs#assignjob"
    patch :assign_job_update
    patch :accept_job
    patch :reject_job
    patch :close_job
  end
  resources :user ,only: [:index, :show]
  resources :notifications

  root 'jobs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end