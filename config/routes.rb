Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pokemons
  
  get('list' => 'pokemons#list')

  namespace 'api' do
    namespace 'v1' do
      get('test' => 'test#index')
    end
  end
end
