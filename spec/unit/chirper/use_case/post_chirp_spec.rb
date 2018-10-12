# frozen_string_literal: true

describe Chirper::UseCase::PostChirp do
  let(:chirp_gateway_spy) { spy(save: created_id) }
  let(:use_case) { described_class.new(chirp_gateway: chirp_gateway_spy) }

  context 'Example one' do
    let(:created_id) { 1 }

    it 'Passes the chirp to the gateway' do
      use_case.execute(username: 'One', body: 'Two')

      expect(chirp_gateway_spy).to have_received(:save) do |chirp|
        expect(chirp.username).to eq('One')
        expect(chirp.body).to eq('Two')
      end
    end

    it 'Returns the id from the gateway' do
      response = use_case.execute(username: 'One', body: 'Two')

      expect(response).to eq(id: 1)
    end
  end

  context 'Example two' do
    let(:created_id) { 5 }

    it 'Passes the chirp to the gateway' do
      use_case.execute(username: 'Three', body: 'Four')

      expect(chirp_gateway_spy).to have_received(:save) do |chirp|
        expect(chirp.username).to eq('Three')
        expect(chirp.body).to eq('Four')
      end
    end

    it 'Returns an empty hash' do
      response = use_case.execute(username: 'Three', body: 'Four')

      expect(response).to eq(id: 5)
    end
  end
end
