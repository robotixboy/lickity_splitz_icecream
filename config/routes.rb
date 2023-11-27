Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #All of our Resources
  resources :customers
  resources :employees
  resources :additions
  resources :foods
  resources :temp_orders
  resources :orders
  resources :food_tags

  #The Home Page of the website
  root 'pages#home'
  #addition !!
  #This will be our testing file for things you would like to testout using the website: (Please Comment this route out when development is over)
  get 'test', to: 'menu#testing', as: 'test'

  #Employee Routes 
  get 'n1e2w3E4m5p6l7o8y9e0R1e2g3i4s5t6e7r8', to: 'employees#admin', as: 'employees_login' #Adding New Employees
  get '1a2d3m4i5n6H7u8b', to: 'employees#home', as: 'employees_home' #Administration Hub :: if the Authorization Key inst correct will redirect you to login or to Non Admin Orders View
  get '1c2u3s4t5o6m7e8r9O0r1d2e3r4s', to: 'employees#orders', as: 'customer_orders' #Customer's Order View :: Shows all non started orders
  get '1E2m3p4l5o6y7e8L9o0g1i2n', to: 'employees#login', as: 'employees_admin_login' #Employee Login

  #Routes for customers to order Items
  get 'confirmation', to: 'menu#confirmation', as: 'order_confirmation'
  get 'orderingMenu', to: 'menu#orderingMenu', as: 'ordering_menu'
  get 'order', to: 'menu#order', as: 'menu_order'
  get 'login', to: 'menu#login'
  get 'icecreamMenu', to: 'menu#iceCreamMenu', as: 'ice_memu'

  #Setting what menu will be shown for the ordering menu 
  get '/set_isBreakfast_true', to: 'menu#set_isBreakfast_true'
  get '/set_isBreakfast_false', to: 'menu#set_isBreakfast_false'

  #Methods in the Employees Controller
  post 'storing_additions', to: 'employees#addition'
  post 'deletingAdditions', to: 'employees#deletingAdditions'
  post 'deletingFoods', to: 'employees#deletingFoods'
  post 'addingNewFood', to: 'employees#addingFood'
  post 'completingOrder', to: 'employees#completingOrder'
  post 'changingTag', to: 'employees#changingTag'
  post 'deletingTags', to: 'employees#deletingTags'
  post 'updatingFoodAdditions', to: 'employees#updatingFoodAdditions'
  post 'checkCredentials', to: 'employees#checkCredentials'
  post 'adminKey', to: 'employees#adminKey'

  #Theses Methods are for forums inside of the menu controller
  post 'deleteTempOrderItem', to: 'menu#deleteTempOrderItem'
  post 'updatingCustomersOrder', to: 'menu#updatingCustomersOrder'

  Rails.application.routes.draw do
    get 'menu/show/:id', to: 'menu#show', as: 'menu_show' # Define a route for showing food details
  end

  Rails.application.routes.draw do
    get 'employees/show/:id', to: 'employees#show', as: 'employees_show' # Define a route for showing food details
  end

end
