require_relative './delivery_mechanism_spec_helper'

describe 'Creating a new chirp' do
  let(:post_chirp_execute_spy) { spy }
  let(:post_chirp_spy) { spy(new: post_chirp_execute_spy) }
  let(:file_chirp_spy) { spy(new: file_chirp_dummy)}

  before do
    stub_const(
      'Chirper::Gateway::FileChirp',
      file_chirp_spy
    )

    stub_const(
      'Chirper::UseCase::PostChirp',
      post_chirp_spy
    )
  end

  context 'Example one' do
    let(:file_chirp_dummy) { 'Dummy' }

    before do
      ENV['CHIRP_FILE_PATH'] = '/tmp/meow.json'

      post(
        '/create-chirp', 
        { username: 'Foo', body: 'Meow' }.to_json
      )
    end

    it 'returns a 200' do
      expect(last_response.status).to eq(200)
    end

    it 'Returns an empty json object' do
      expect(JSON.parse(last_response.body)).to eq({})
    end

    it 'Creates the gateway with the correct file path' do
      expect(file_chirp_spy).to have_received(:new).with(file_path: '/tmp/meow.json')
    end

    it 'Creates the usecase with the gateway' do
      expect(post_chirp_spy).to have_received(:new).with(chirp_gateway: file_chirp_dummy)
    end

    it 'Passes the chirp to the usecase' do
      expect(post_chirp_execute_spy).to(
        have_received(:execute).with(username: 'Foo', body: 'Meow')
      )
    end
  end

  context 'Example two' do
    let(:file_chirp_dummy) { 'Also a dummy' }

    before do
      ENV['CHIRP_FILE_PATH'] = '/tmp/woof.json'

      post(
        '/create-chirp', 
        { username: 'Bar', body: 'Woof' }.to_json
      )
    end

    it 'returns a 200' do
      expect(last_response.status).to eq(200)
    end

    it 'Returns an empty json object' do
      expect(JSON.parse(last_response.body)).to eq({})
    end

    it 'Creates the gateway with the correct file path' do
      expect(file_chirp_spy).to have_received(:new).with(file_path: '/tmp/woof.json')
    end

    it 'Creates the usecase with the gateway' do
      expect(post_chirp_spy).to have_received(:new).with(chirp_gateway: file_chirp_dummy)
    end

    it 'Passes the chirp to the usecase' do
      expect(post_chirp_execute_spy).to(
        have_received(:execute).with(username: 'Bar', body: 'Woof')
      )
    end
  end
end
