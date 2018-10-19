# frozen_string_literal: true

describe 'Creating dem chirps' do
  let(:chirp_file) { '/tmp/chirps.json' }

  before do
    File.open(chirp_file, 'w') {}
  end

  after do
    File.delete(chirp_file)
  end

  it 'allows me to post and view chirps' do
    chirp_gateway = Chirper::Gateway::FileChirp.new(file_path: '/tmp/chirps.json')
    create_new_chirps = Chirper::UseCase::PostChirp.new(chirp_gateway: chirp_gateway)
    view_chirps = Chirper::UseCase::ViewChirps.new(chirp_gateway: chirp_gateway)
    favourite_chirp = Chirper::UseCase::FavouriteChirp.new(chirp_gateway: chirp_gateway)

    created_chirp = create_new_chirps.execute(
      username: 'Test One',
      body: 'I just want to pet all the cats.'
    )

    create_new_chirps.execute(
      username: 'Test Two',
      body: 'All dogs are good dogs.'
    )

    favourite_chirp.execute(id: created_chirp[:id])

    chirps = view_chirps.execute

    expect(chirps[0]).to eq(
      id: 0,
      username: 'Test One',
      body: 'I just want to pet all the cats.',
      favourites: 1
    )

    expect(chirps[1]).to eq(
      id: 1,
      username: 'Test Two',
      body: 'All dogs are good dogs.',
      favourites: 0
    )
  end
end
