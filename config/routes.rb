Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "soapf/getbyid"
  get "soapf/getbymateria"
  wash_out :interface

end
