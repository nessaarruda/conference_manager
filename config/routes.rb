Rails.application.routes.draw do
  get '/', to:'welcome#index'

  get '/conferences', to: 'conferences#index'
end
