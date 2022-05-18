Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end
  # post "/graphql", to: "graphql#execute"


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  get 'pages/get-years'
  get 'pages/index'
  get 'pages/dynamic-plan-execution'
  get 'pages/dynamic-indexed-sales'
  get 'pages/product-group-structure'
  get 'pages/payment-method-sctructure'
  get 'pages/trade-form-sctructure'
  get 'pages/seasonality-sctructure'
  get 'pages/average-prices'
  get 'pages/abs-product-analysis'
  get 'pages/xyz_analysis'
  get 'pages/sales-forecast'





  match '*path' => redirect('/'), via: :get

end
