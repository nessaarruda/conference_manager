Rails.application.routes.draw do
  get '/', to:'welcome#index'

  get '/meeting_rooms', to:'meeting_rooms#index'
  get '/meeting_rooms/new', to:'meeting_rooms#new'
  post '/meeting_rooms', to:'meeting_rooms#create'
  get '/meeting_rooms/:id', to:'meeting_rooms#show'
  get '/meeting_rooms/:id/edit', to: 'meeting_rooms#edit'
  patch '/meeting_rooms/:id', to: 'meeting_rooms#update'
  delete '/meeting_rooms/:id', to: 'meeting_rooms#destroy'

  get '/meetings', to: 'meetings#index'
  get '/meeting_rooms/:id/meetings', to: 'meetings#index'
  get '/meeting_rooms/:id/meetings/new', to: 'meetings#new'
  post '/meeting_rooms/:id/meetings', to: 'meetings#create'
  get '/meetings/:id', to: 'meetings#show', as: 'meeting'
  get '/meetings/:id/edit', to: 'meetings#edit'
  patch '/meetings/:id', to: 'meetings#update'
  delete '/meetings/:id', to: 'meetings#destroy'


  get '/conferences', to: 'conferences#index'
  get '/conferences/new', to: 'conferences#new'
  post '/conferences', to: 'conferences#create'
  get '/conferences/:id', to: 'conferences#show'
  get '/conferences/:id/edit', to: 'conferences#edit'
  patch '/conferences/:id', to: 'conferences#update'
  delete '/conferences/:id', to: 'conferences#destroy'


  get '/presentations', to: 'presentations#index'
  get '/conferences/:id/presentations', to: 'presentations#index'
  get '/conferences/:id/presentations/new', to: 'presentations#new'
  post '/conferences/:id/presentations', to: 'presentations#create'
  get '/presentations/:id', to: 'presentations#show', as: 'presentation'
  get '/presentations/:id/edit', to: 'presentations#edit'
  patch '/presentations/:id', to: 'presentations#update'
  delete '/presentations/:id', to: 'presentations#destroy'
end
