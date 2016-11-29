Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get ':slug', to: 'link#show'
  resources :link
  root 'main#index'
end
