Rails.application.routes.draw do
  get '/', to:'welcome#index'

  get '/meeting_rooms', to:'meeting_rooms#index'
  get '/meeting_rooms/:id', to:'meeting_rooms#show'


  get '/conferences', to: 'conferences#index'
  get '/conferences/new', to: 'conferences#new'
  post '/conferences', to: 'conferences#create'
  get '/conferences/:id', to: 'conferences#show'
  get '/conferences/:id/edit', to: 'conferences#edit'
  patch '/conferences/:id', to: 'conferences#update'
  delete '/conferences/:id', to: 'conferences#destroy'
end
