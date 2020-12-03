Rails.application.routes.draw do
  get '/', to:'welcome#index'

  get '/conferences', to: 'conferences#index'
  get '/conferences/new', to: 'conferences#new'
  post '/conferences', to: 'conferences#create'
  get '/conferences/:id', to: 'conferences#show'
  get '/conferences/:id/edit', to: 'conferences#edit'
  patch '/conferences/:id', to: 'conferences#update'
end
