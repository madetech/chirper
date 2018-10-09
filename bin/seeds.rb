# frozen_string_literal: true

class Seeds
  def self.execute
    File.open(ENV['CHIRP_FILE_PATH'], 'w') {} unless File.file?(ENV['CHIRP_FILE_PATH'])

    chirp_gateway = Chirper::Gateway::FileChirp.new(
      file_path: ENV['CHIRP_FILE_PATH']
    )

    post_chirp = Chirper::UseCase::PostChirp.new(
      chirp_gateway: chirp_gateway
    )

    timeline = Chirper::UseCase::ViewChirps.new(
      chirp_gateway: chirp_gateway
    )

    if timeline.execute.empty?
      post_chirp.execute(username: 'Cats4Lyf', body: 'Cats are great')
      post_chirp.execute(username: 'Dogs4Eva', body: 'All dogs are good dogs')
    end
  end
end
