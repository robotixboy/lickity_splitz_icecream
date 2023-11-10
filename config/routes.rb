Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :customers
  resources :employee
  resources :employees
  resources :additions
  resources :foods
  resources :temp_orders
  resources :orders
  resources :food_tags

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  # root 'menu#login'

  get 'HotCrossBuns', to: 'testing#HotCrossBuns', as: 'hot_cross_buns'
  get 'order', to: 'menu#order', as: 'menu_order'
  get 'login', to: 'menu#login'
  get 'employees', to: 'employee#login', as: 'employee_login'
  get 'admin', to: 'employees#admin', as: 'employees_login'
  get 'home', to: 'employees#home', as: 'employees_home'
  get 'customerOrders', to: 'employees#orders', as: 'customer_orders'
  post 'storing_additions', to: 'employees#addition'
  post 'deletingAdditions', to: 'employees#deletingAdditions'
  post 'addingNewFood', to: 'employees#addingFood'
  post 'completingOrder', to: 'employees#completingOrder'
  post 'changingTag', to: 'employees#changingTag'
  post 'deletingTags', to: 'employees#deletingTags'
  post 'updatingFoodAdditions', to: 'employees#updatingFoodAdditions'
  get 'confirmation', to: 'menu#confirmation', as: 'order_confirmation'
  get 'orderingMenu', to: 'menu#orderingMenu', as: 'ordering_menu'
  get '/set_isBreakfast_true', to: 'menu#set_isBreakfast_true'
  get '/set_isBreakfast_false', to: 'menu#set_isBreakfast_false'

  Rails.application.routes.draw do
    get 'menu/show/:id', to: 'menu#show', as: 'menu_show' # Define a route for showing food details
  end

  Rails.application.routes.draw do
    get 'employees/show/:id', to: 'employees#show', as: 'employees_show' # Define a route for showing food details
  end

end
