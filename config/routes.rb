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

  namespace :api,:defaults => {:format => :json} do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :jobs
    resources :user ,only: [:index, :show]
    patch :accept_job ,to: "jobs#accept_job"
    patch :reject_job ,to: "jobs#reject_job"
    patch :close_job ,to: "jobs#close_job"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end