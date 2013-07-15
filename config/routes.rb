OneteamApp::Application.routes.draw do 

  get "skills/new"

  root to: 'sessions#new'
  
  match '/home', to: 'static_pages#home'
  match '/help', to: 'static_pages#help'
  match '/signup', to: 'employees#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  match '/employees/:employee_id/requests' => 'requests#index', :as => :employee_requests
 
  match '/dashboards/requests_overview' => 'dashboards#requests_overview', :as => :dashboard_requests_overview
  match '/dashboards/skills_overview' => 'dashboards#skills_overview', :as => :dashboard_skills_overview
  match '/dashboards/guest_developers_overview' => 'dashboards#guest_developers_overview', :as => :dashboard_guest_developers_overview



  resources :employees
  resources :static_pages
  resources :sessions, only: [:new, :create, :destroy]
  resources :skills
  resources :employee_skills
  resources :target_skills
  resources :request_skills  
  resources :dashboards
  resources :locations

  resources :employee_locations

  resources :requests, :shallow => true do
    resources :responses
  end

  resources :responses, :shallow => true do
    resources :employees
    resources :selections
  end

  resources :responses do    
    resources :evaluations  
  end 

end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

