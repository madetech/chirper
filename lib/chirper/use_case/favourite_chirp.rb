# frozen_string_literal: true

class Chirper::UseCase::FavouriteChirp
  def initialize(chirp_gateway:)
    @chirp_gateway = chirp_gateway
  end

  def execute(id:)
    @chirp_gateway.favourite(id: id)

    {}
  end
end
