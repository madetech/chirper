# frozen_string_literal: true

require_relative './delivery_mechanism_spec_helper'

describe 'Favouriting a chirp' do
  let(:favourite_chirp_execute_spy) { spy }
  let(:favourite_chirp_spy) { spy(new: favourite_chirp_execute_spy) }
  let(:file_chirp_spy) { spy(new: file_chirp_dummy) }

  before do
    stub_const(
      'Chirper::Gateway::FileChirp',
      file_chirp_spy
    )

    stub_const(
      'Chirper::UseCase::FavouriteChirp',
      favourite_chirp_spy
    )
  end

  context 'Example one' do
    let(:file_chirp_dummy) { 'Dummy' }

    before do
      ENV['CHIRP_FILE_PATH'] = '/tmp/meow.json'

      post(
        '/favourite',
        { id: 10 }.to_json
      )
    end

    it 'returns a 200' do
      expect(last_response.status).to eq(200)
    end

    it 'Creates the gateway with the correct file path' do
      expect(file_chirp_spy).to have_received(:new).with(file_path: '/tmp/meow.json')
    end

    it 'Creates the usecase with the gateway' do
      expect(favourite_chirp_spy).to have_received(:new).with(chirp_gateway: file_chirp_dummy)
    end

    it 'Passes the chirp to the usecase' do
      expect(favourite_chirp_execute_spy).to(
        have_received(:execute).with(id: 10)
      )
    end
  end

  context 'Example two' do
    let(:file_chirp_dummy) { 'Dummy' }

    before do
      ENV['CHIRP_FILE_PATH'] = '/tmp/meow.json'

      post(
        '/favourite',
        { id: 20 }.to_json
      )
    end

    it 'returns a 200' do
      expect(last_response.status).to eq(200)
    end

    it 'Creates the gateway with the correct file path' do
      expect(file_chirp_spy).to have_received(:new).with(file_path: '/tmp/meow.json')
    end

    it 'Creates the usecase with the gateway' do
      expect(favourite_chirp_spy).to have_received(:new).with(chirp_gateway: file_chirp_dummy)
    end

    it 'Passes the chirp to the usecase' do
      expect(favourite_chirp_execute_spy).to(
        have_received(:execute).with(id: 20)
      )
    end
  end
end
