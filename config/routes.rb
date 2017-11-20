Rails.application.routes.draw do
  root to: 'longestwords#home'

  get 'longestwords/game'

  get 'longestwords/score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
