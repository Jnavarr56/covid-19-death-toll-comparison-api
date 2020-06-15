Rails.application.routes.draw do
  get '/results', to: 'results#get_results'
  get '/sources', to: 'results#get_sources'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
