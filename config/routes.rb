Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'

  resources :tasks do
    resources :subtasks
    resources :reminders
  end

  resources :events do
    resources :tasks do
      resources :subtasks
      resources :reminders
    end
  end

  resources :notes
  resources :reminders

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
