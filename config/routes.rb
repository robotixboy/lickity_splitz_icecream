Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :customers




  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  # root 'menu#login'

  get 'HotCrossBuns', to: 'testing#HotCrossBuns', as: 'hot_cross_buns'
  get 'order', to: 'menu#order', as: 'menu_order'


  get 'HotCrossBunsPart2', to: 'testing#CrossHot'
  get 'login', to: 'menu#login'



end
