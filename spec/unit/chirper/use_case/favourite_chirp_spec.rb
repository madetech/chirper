# frozen_string_literal: true

describe Chirper::UseCase::FavouriteChirp do
  let(:chirp_gateway_spy) { spy }
  let(:use_case) { described_class.new(chirp_gateway: chirp_gateway_spy) }
  let(:response) { use_case.execute(id: id) }

  before { response }

  context 'Example one' do
    let(:id) { 1 }

    it 'Calls the favourite method on the chirp gateway' do
      expect(chirp_gateway_spy).to have_received(:favourite)
    end

    it 'Passes the ID to the gateway' do
      expect(chirp_gateway_spy).to have_received(:favourite).with(id: 1)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end

  context 'Example two' do
    let(:id) { 5 }

    it 'Calls the favourite method on the chirp gateway' do
      expect(chirp_gateway_spy).to have_received(:favourite)
    end

    it 'Passes the ID to the gateway' do
      expect(chirp_gateway_spy).to have_received(:favourite).with(id: 5)
    end

    it 'returns an empty hash' do
      expect(response).to eq({})
    end
  end
end
