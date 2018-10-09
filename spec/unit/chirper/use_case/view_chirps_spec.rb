describe Chirper::UseCase::ViewChirps do
  let(:chirp_gateway_spy) { spy(all: chirps) }
  let(:use_case) { described_class.new(chirp_gateway: chirp_gateway_spy) }

  context 'Example one' do
    let(:chirps) do
      chirp = Chirper::Domain::Chirp.new.tap do |c|
        c.username = 'One'
        c.body = 'Cat'
      end

      [ chirp ]
    end

    it 'Gets all the chirps from the gateway' do
      use_case.execute

      expect(chirp_gateway_spy).to have_received(:all)
    end

    it 'Returns the chirps' do
      response = use_case.execute

      expect(response[0][:username]).to eq('One')
      expect(response[0][:body]).to eq('Cat')
    end
  end

  context 'Example two' do
    let(:chirps) do
      chirp_one = Chirper::Domain::Chirp.new.tap do |c|
        c.username = 'Two'
        c.body = 'Dog'
      end

      chirp_two = Chirper::Domain::Chirp.new.tap do |c|
        c.username = 'Three'
        c.body = 'Quack'
      end

      [ chirp_one, chirp_two ]
    end

    it 'Gets all the chirps from the gateway' do
      use_case.execute

      expect(chirp_gateway_spy).to have_received(:all)
    end

    it 'Returns the chirps' do
      response = use_case.execute

      expect(response[0][:username]).to eq('Two')
      expect(response[0][:body]).to eq('Dog')

      expect(response[1][:username]).to eq('Three')
      expect(response[1][:body]).to eq('Quack')
    end
  end
end
