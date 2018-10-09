class Chirper::Gateway::FileChirp
  def initialize(file_path:)
    @file_path = file_path
  end

  def save(chirp)
    chirps = saved_chirps

    chirps << chirp_to_hash(chirp)

    File.open(@file_path, 'w') do |f|
      f.write(chirps.to_json)
    end
  end

  def all
    saved_chirps.map do |chirp|
      Chirper::Domain::Chirp.new.tap do |c|
        c.username = chirp['username']
        c.body = chirp['body']
      end
    end
  end

  private 

  def saved_chirps
    chirps = []

    File.open(@file_path, 'r') do |f|
      raw_chirps = f.read()
      chirps = JSON.parse(raw_chirps) unless raw_chirps.empty?
    end

    chirps
  end

  def chirp_to_hash(chirp) 
    {
      username: chirp.username,
      body: chirp.body
    }
  end
end