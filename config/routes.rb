Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/', to: 'requests#new'

  post '/requests', to: 'requests#create'

  get '/requests/:id', to: 'requests#show'
end
