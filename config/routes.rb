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
  get '/meeting_rooms/:id/meetings/new', to: 'meetings#new'
  get '/meeting_rooms/:id/meetings', to: 'meetings#index'
  get '/meetings/:id', to: 'meetings#show'
  post '/meetings', to: 'meetings#create'
end
