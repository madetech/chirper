# frozen_string_literal: true

class Chirper::Gateway::FileChirp
  def initialize(file_path:)
    @file_path = file_path
  end

  def save(chirp)
    chirps = saved_chirps

    chirp.id = chirps.length

    chirps << chirp_to_hash(chirp)

    File.open(@file_path, 'w') do |f|
      f.write(chirps.to_json)
    end

    chirp.id
  end

  def all
    saved_chirps.map do |chirp|
      Chirper::Domain::Chirp.new.tap do |c|
        c.id = chirp['id']
        c.username = chirp['username']
        c.body = chirp['body']
      end
    end
  end

  private

  def saved_chirps
    chirps = []

    File.open(@file_path, 'r') do |f|
      raw_chirps = f.read
      chirps = JSON.parse(raw_chirps) unless raw_chirps.empty?
    end

    chirps
  end

  def chirp_to_hash(chirp)
    {
      id: chirp.id,
      username: chirp.username,
      body: chirp.body
    }
  end
end
