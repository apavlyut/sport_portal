ActionController::Routing::Routes.draw do |map|
  map.resources :index, :plural => "index"
  
  ##### NEW ROUTES
  
  # Правление
  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :exercises, :member => "deattach_muscle"
    admin.resources :muscular_groups, :has_many => :muscles
  end
  
  map.admin "admin/", :controller => "admin/users"
  
  # Сообщество
  map.namespace :hangout do |hangout|
    # Персоналии
    hangout.resources :people 
    # Места - клубы, еще что-нибудь ...
    hangout.resources :places
    # Группы
    hangout.resources :groups, :has_many => :forums # С форумами
  
    # ...
  end
  
  # Тренировочные программы
  map.resources :workouts, :member => { :add_exercise => :get, :step_4 => :get, :remove_day_line => :get, :pring_version => :get } do |workout|
    workout.resources :exercises
  end
  
  map.resources :muscular_groups, :has_many => :exercises
  
  ##### END OF NEW ROUTES
    
  map.resource :index
  map.resources :workouts
  map.resources :comments
  map.resources :posts, :has_many => :comments

  map.resources :messages
  map.messages_out '/messages_outbox', :controller => 'messages', :action => 'outbox'

  map.resources :products

  map.resources :images

  map.resources :categories

  map.resources :top_menus

  map.resources :roles
  
  map.resources :muscles
  
  map.resources :exercises, :member => "deattach_muscle"
  
  map.fitness "/fitness", :controller => "fitness"
  map.resource :fitness, :plural => "fitness", :has_many => ["workouts", "exercises"]
  
  map.management "/management", :controller => "management"
  
  map.resource :management, :plural => "management", :has_many => ["exercises", "muscles", "users", "roles"]
  
  # Настраиваем роты для магазина
  # Доступ к каталогу через именя категорий
  
  map.connect 'shop', :controller => "products", :action => 'index', :title => 'all'
  
  map.connect 'shop/:title/products', :controller => "products", :action => 'index'
  map.connect 'shop/:title/products/:id', :controller => "products", :action => 'show'
  map.connect 'shop/:title/products/:id/:action', :controller => "products"
  
  # Доступ к корзине через магазин
  map.cart 'shop/cart', :controller => "cart", :action => 'show'
  
  # Роуты для блогов
  map.blogs 'blogs/', :controller => 'posts', :action => 'index'
  map.new_post 'blogs/new_post', :controller => 'posts', :action => 'new'
  map.connect 'blogs/:user_id', :controller => 'posts', :action => 'index', :user_id => nil
  map.connect 'blogs/:user_id/:id', :controller => 'posts', :action => 'show'
  map.connect 'blogs/:user_id/:id/add_comment', :controller => 'comments', :action => 'create'
  
  map.root :controller => "index", :action => "index"
  
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.activate '/activate/:id', :controller => 'accounts', :action => 'show'
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.change_password '/change_password/:id', :controller => 'accounts', :action => 'edit'
  
  # See how all your routes lay out with "rake routes"
  map.resources :pages, :users
 
  map.resources :users, :member => { :enable => :put } do |users|
    users.resource :account
    users.resources :roles
  end
  
  map.resource :session
  map.resource :password
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

    
end
