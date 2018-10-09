class Chirper::UseCase::ViewChirps
  def initialize(chirp_gateway:)
    @chirp_gateway = chirp_gateway
  end

  def execute
    @chirp_gateway.all.map do |chirp|
      {
        username: chirp.username, 
        body: chirp.body
      }
    end
  end
end
