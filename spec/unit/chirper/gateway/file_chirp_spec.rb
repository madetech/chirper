describe Chirper::Gateway::FileChirp do
  let(:gateway) { described_class.new(file_path: file_path) }

  before do
    File.open(file_path, 'w') {}
  end

  after do
    File.delete(file_path)
  end

  context 'A single chirp' do 
    context 'Example one' do
      let(:file_path) { '/tmp/cats.json' }

      it 'Saves a new chirp' do
        chirp = Chirper::Domain::Chirp.new
        chirp.username = 'One' 
        chirp.body = 'Meow'

        gateway.save(chirp)

        chirps = gateway.all

        expect(chirps.first.username).to eq('One')
        expect(chirps.first.body).to eq('Meow')
      end
    end

    context 'Example two' do
      let(:file_path) { '/tmp/dogs.json' }

      it 'Saves a new chirp' do
        chirp = Chirper::Domain::Chirp.new
        chirp.username = 'Two' 
        chirp.body = 'Woof'

        gateway.save(chirp)

        chirps = gateway.all

        expect(chirps.first.username).to eq('Two')
        expect(chirps.first.body).to eq('Woof')
      end
    end
  end

  context 'Saving multiple chirps' do
    let(:file_path) { '/tmp/animals.json' }

    it 'Saves new chirps' do
      chirp_one = Chirper::Domain::Chirp.new
      chirp_one.username = 'Cats4lyf' 
      chirp_one.body = 'I love cats'

      chirp_two = Chirper::Domain::Chirp.new
      chirp_two.username = 'Dogs4eva' 
      chirp_two.body = 'All dogs are the best dogs'

      gateway.save(chirp_one)
      gateway.save(chirp_two)

      chirps = gateway.all

      expect(chirps[0].username).to eq('Cats4lyf')
      expect(chirps[0].body).to eq('I love cats')

      expect(chirps[1].username).to eq('Dogs4eva')
      expect(chirps[1].body).to eq('All dogs are the best dogs')
    end
  end
end