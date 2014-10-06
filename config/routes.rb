Rails.application.routes.draw do
  get '', to: 'application#index'
  get 'beco', to: 'application#beco'
  get 'cdl', to: 'application#cdl'
  get 'cucko', to: 'application#cucko'
end
