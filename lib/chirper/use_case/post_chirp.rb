class Chirper::UseCase::PostChirp
  def initialize(chirp_gateway:)
    @chirp_gateway = chirp_gateway
  end

  def execute(username:, body:)
    chirp = Chirper::Domain::Chirp.new
    chirp.username = username
    chirp.body = body
    @chirp_gateway.save(chirp)

    {}
  end
end
