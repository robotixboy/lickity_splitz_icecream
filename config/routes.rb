Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :customers
  resources :employee
  resources :additions
  resources :foods
  resources :temp_order






  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  # root 'menu#login'

  get 'HotCrossBuns', to: 'testing#HotCrossBuns', as: 'hot_cross_buns'
  get 'order', to: 'menu#order', as: 'menu_order'
  get 'login', to: 'menu#login'
  get 'employees', to: 'employee#login', as: 'employee_login'


  post 'storing_additions', to: 'employee#addition'
  post 'addingNewFood', to: 'employee#addingFood'



end
