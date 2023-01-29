Rails.application.routes.draw do

devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
get 'about' => 'public/homes#about'
  root 'public/homes#top'

  scope module: :public do
    resources :items,only: [:index,:show]
    
    get 'customer/edit' => 'customers#edit'
    put 'customer' => 'customers#update'
    get 'customer' => 'customers#show'
    get 'customer' => 'customers#destoroy'
    get 'customer/quit' => 'customers#quit'
    patch 'customer/out' => 'customers#out'

      resources :cart_items,only: [:index,:update,:create,:destroy] do
        collection do
          delete '/' => 'cart_items#all_destroy'
        end
      end

      resources :orders,only: [:new,:index,:show,:create] do
        collection do
          post 'log'
          get 'thanks'
        end
      end

      resources :addresses,only: [:index,:create,:edit,:update,:destroy]
   end

devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
    resources :customers,only: [:index,:show,:edit,:update]
    resources :items,only: [:index,:new,:create,:show,:edit,:update,]
    resources :genres,only: [:index,:create,:edit,:update, :show]
    resources :orders,only: [:index,:show,:update] do
  	  member do
        get :current_index
        resources :order_items,only: [:update]
      end
     end
    end
 end
