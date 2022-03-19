Rails.application.routes.draw do
 
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"
  
  get "bookings/:id", to: "activities#booking", as: "bookings"
  post "bookings/:id", to: "activities#book", as: "book"
  get "myactivities", to: "activities#myactivity", as: "myactivities"
  get "mykidactivities", to: "activities#mykidactivity", as: "mykidactivities"
  get "restricted", to: "pages#restricted" 
  get "activities", to: "activities#index", as: "activities"
  post "activities", to: "activities#create"
  get "activities/new", to: "activities#new", as: "new_activity"
  get "activities/:id", to: "activities#show", as: "activity"
  put "activities/:id", to: "activities#update"
  patch "activities/:id", to: "activities#update"
  delete "activities/:id", to: "activities#destroy", as: "delete_activity"
  get "activities/:id/edit", to: "activities#edit", as: "edit_activity"
end
