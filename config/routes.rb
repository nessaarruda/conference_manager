Rails.application.routes.draw do
  get '/', to:'welcome#index'
  get '/meeting_rooms', to:'meeting_rooms#index'
  get '/meeting_rooms/new', to:'meeting_rooms#new'
  get '/meeting_rooms', to:'meeting_rooms#create'
end
