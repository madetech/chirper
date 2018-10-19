# frozen_string_literal: true

class Chirper::UseCase::ViewChirps
  def initialize(chirp_gateway:)
    @chirp_gateway = chirp_gateway
  end

  def execute
    @chirp_gateway.all.map do |chirp|
      {
        id: chirp.id,
        username: chirp.username,
        body: chirp.body,
        favourites: chirp.favourites
      }
    end
  end
end
