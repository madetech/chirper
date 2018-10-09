require 'sinatra'

module DeliveryMechanism
  class WebRoutes < Sinatra::Base
    get '/' do
      'Meow'
    end
  end
end