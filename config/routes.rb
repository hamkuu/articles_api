Rails.application.routes.draw do
  # api/v1/METHOD_FAMILY.method
  scope module: 'api', path: 'api', as: 'api' do
    scope module: 'v1', path: 'v1', as: 'v1' do
      resources :articles, only: [:index, :show, :new, :create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
