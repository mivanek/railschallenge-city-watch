Rails.application.routes.draw do
  resources :responders, param: :name, only: [:create, :index, :show, :update]

  match '*path', to: 'application#render_404', via: :all
end
