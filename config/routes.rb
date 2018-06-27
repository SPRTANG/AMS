Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  post   '/assignments/new',   to: 'assignments#new'
  get  '/assignment/download_attachment', to:  'assignments#download_attachment'
  post  '/assignment/download_attachment', to:  'assignments#download_attachment'
  post '/check_upcoming_dued_assignment', to: 'assignments#check_upcoming_dued_assignment'
  get '/check_upcoming_dued_assignment', to: 'assignments#check_upcoming_dued_assignment'
  post '/check_stats', to: 'assignments#check_stats'
  get '/check_stats', to: 'assignments#check_stats'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :assignments

  get 'users/new'
  get 'dashboard/profile'
  get 'authentication/signin'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
