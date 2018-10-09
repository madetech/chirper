require_relative './delivery_mechanism_spec_helper'

describe 'Getting the timeline' do
  let(:view_chirps_execute_spy) { spy(execute: chirps) }
  let(:view_chirps_spy) { spy(new: view_chirps_execute_spy) }
  let(:file_chirp_spy) { spy(new: file_chirp_dummy)}

  before do
    stub_const(
      'Chirper::Gateway::FileChirp',
      file_chirp_spy
    )

    stub_const(
      'Chirper::UseCase::ViewChirps',
      view_chirps_spy
    )
  end

  context 'Example one' do
    let(:file_chirp_dummy) { 'This is a dummy' }
    let(:chirps) do 
      [
        {
          username: 'Cats4Lyf', body: 'Cats Rule'
        }
      ]
    end

    before do
      ENV['CHIRP_FILE_PATH'] = '/tmp/meow.json'

      get '/timeline'
    end

    it 'Returns a 200' do
      expect(last_response.status).to eq(200)
    end

    it 'Gets the chirp gateway with the correct path' do
      expect(file_chirp_spy).to(
        have_received(:new).with(file_path: '/tmp/meow.json')
      )
    end

    it 'Creates the usecase with the gateway' do
      expect(view_chirps_spy).to have_received(:new).with(chirp_gateway: file_chirp_dummy)
    end

    it 'Calls execute on the usecase' do
      expect(view_chirps_execute_spy).to have_received(:execute)
    end

    it 'Returns the chirps from the use case' do
      response_body = JSON.parse(last_response.body)

      expect(response_body[0]['username']).to eq('Cats4Lyf')
      expect(response_body[0]['body']).to eq('Cats Rule')
    end
  end

  context 'Example two' do
    let(:file_chirp_dummy) { 'This is also a dummy' }
    let(:chirps) do
      [
        { username: 'Dogs4Eva', body: 'Dogs are good' },
        { username: 'Dogs4Eva', body: 'All of them are good' }
      ]
    end

    before do
      ENV['CHIRP_FILE_PATH'] = '/tmp/woof.json'

      get '/timeline'
    end

    it 'Returns a 200' do
      expect(last_response.status).to eq(200)
    end

    it 'Gets the chirp gateway with the correct path' do
      expect(file_chirp_spy).to(
        have_received(:new).with(file_path: '/tmp/woof.json')
      )
    end

    it 'Creates the usecase with the gateway' do
      expect(view_chirps_spy).to have_received(:new).with(chirp_gateway: file_chirp_dummy)
    end

    it 'Calls execute on the usecase' do
      expect(view_chirps_execute_spy).to have_received(:execute)
    end

    it 'Returns the chirps from the use case' do
      response_body = JSON.parse(last_response.body)

      expect(response_body[0]['username']).to eq('Dogs4Eva')
      expect(response_body[0]['body']).to eq('Dogs are good')

      expect(response_body[1]['username']).to eq('Dogs4Eva')
      expect(response_body[1]['body']).to eq('All of them are good')
    end
  end
end
