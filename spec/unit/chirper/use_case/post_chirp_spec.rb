describe Chirper::UseCase::PostChirp do
  let(:chirp_gateway_spy) { spy }
  let(:use_case) { described_class.new(chirp_gateway: chirp_gateway_spy) }

  context 'Example one' do
    it 'Passes the chirp to the gateway' do
      use_case.execute(username: 'One', body: 'Two')

      expect(chirp_gateway_spy).to have_received(:save) do |chirp|
        expect(chirp.username).to eq('One')
        expect(chirp.body).to eq('Two')
      end
    end

    it 'Returns an empty hash' do
      response = use_case.execute(username: 'One', body: 'Two')

      expect(response).to eq({})
    end
  end

  context 'Example two' do
    it 'Passes the chirp to the gateway' do
      use_case.execute(username: 'Three', body: 'Four')

      expect(chirp_gateway_spy).to have_received(:save) do |chirp|
        expect(chirp.username).to eq('Three')
        expect(chirp.body).to eq('Four')
      end
    end

    it 'Returns an empty hash' do
      response = use_case.execute(username: 'Three', body: 'Four')

      expect(response).to eq({})
    end
  end
end
