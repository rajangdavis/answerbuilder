Answerbuild::Application.routes.draw do
  root "sessions#new" 
  delete '/logout' => 'sessions#destroy', as: :logout
  resources :sessions
  resources :users, except: :destroy
  resources :answers, except: :destroy
  resources :steps

  get 'answers__' => 'answers#index3', as: :index3
  get 'answers_' => 'answers#index2', as: :index2
  get 'automate' => 'answers#automate', as: :automate
  get 'qsee_updates' => 'answers#qsee_updates', as: :qsee_updates
  get 'answers/:id/code' => 'answers#code2', as: :code
  get 'answers/:id/answer' => 'answers#alt_answer', as: :angular
  get 'answers/:id/answer_jp' => 'answers#answer_jp', as: :angular_jp
  get 'answers/:id/inspect' => 'answers#inspect', as: :inspect
  get 'inspect_all' => 'answers#inspect_all', as: :inspect_all
  get 'qsee_rn_array' => 'answers#qsee_rn_array', as: :qsee_rn_array
  get 'qsee_rn_partial/:id' => 'answers#qsee_rn_partial', as: :qsee_rn_partial
  get 'strings' => 'answers#strings', as: :strings
  get 'translate/:id' => 'answers#translate', as: :translate
  get 'translation_portal' => 'answers#translate_index', as: :translate_index
  get 'spreadsheet' => 'answers#spreadsheet', as: :spreadsheet
  get 'answers/:id/preview' => 'answers#preview', as: :preview
  get 'answers/:id/preview_jp' => 'answers#preview_jp', as: :preview_jp
  get 'stepss' => 'steps#index2',as: :imagedump
  get 'qtpojo' => 'answers#qtpojo'

  get 'answers/:id/test' => 'answers#test'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
