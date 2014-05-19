Cerberus::Application.routes.draw do

  # Root #################
  root 'pages#home'

  # Players Resource #################
  resources :players

  get 'players/:id/towns' => 'players#towns', as: :player_towns


  # Alliances Resoures #################
  resources :alliances
  get 'alliances/:id/towns' => 'alliances#towns', as: :alliance_towns
  get 'alliances/:id/members' => 'alliances#members', as: :alliance_members

  # Towns Resource #################
  resources :towns

  # Islands Resouce #################
  resources :islands

  # Conquer Resource #################
  resources :conquers

  # Pages Resource #################
  get 'status' => 'pages#status', as: :status

end
