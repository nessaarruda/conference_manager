Rails.application.routes.draw do
  get '/', to:'welcome#index'

  get '/conferences', to: 'conferences#index'
  get '/conferences/:id', to: 'conferences#show'
end
