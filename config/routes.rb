Rails.application.routes.draw do
  get 'production_companies/index'
  get 'production_companies/show'
  get 'movies/index'
  get 'movies/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

=begin
  GET /
  GET /Movies
  GET /Movies/:id
  GET /production_companies
  GET /production_companies/:id
=end
end
