Rails.application.routes.draw do
  get '/', to:'welcome#index'
  get '/meeting_rooms', to:'meeting_rooms#index'
  get '/meeting_rooms/new', to:'meeting_rooms#new'
  post '/meeting_rooms', to:'meeting_rooms#create'
  get '/meeting_rooms/:id', to:'meeting_rooms#show'
  get '/meeting_rooms/:id/edit', to: 'meeting_rooms#edit'
  get '/meeting_rooms/:id/meetings', to: 'meetings#index'
  patch '/meeting_rooms/:id', to: 'meeting_rooms#update'
  delete '/meeting_rooms/:id', to: 'meeting_rooms#destroy'

  get '/meetings', to: 'meetings#index'
  post '/meetings', to: 'meetings#create'
  get '/meetings/:id', to: 'meetings#show'
  get '/meeting_rooms/:id/meetings', to: 'meetings#index'
  get '/meeting_rooms/:id/meetings/new', to: 'meetings#new'
  get '/meetings/:id/edit', to: 'meetings#edit'
  patch '/meetings/:id', to: 'meetings#update'
end
