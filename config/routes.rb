Rails.application.routes.draw do
  get '/', to:'welcome#index'

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
  post '/presentations', to: 'presentations#create'
  get '/presentations/:id', to: 'presentations#show'
  get '/presentations/:id/edit', to: 'presentations#edit'
  patch '/presentations/:id', to: 'presentations#update'
  delete '/presentations/:id', to: 'presentations#destroy'

  get '/meeting_rooms', to: 'meeting_rooms#index'
end
