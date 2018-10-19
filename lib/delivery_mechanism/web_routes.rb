# frozen_string_literal: true

require 'sinatra'

$stdout.sync = true

module DeliveryMechanism
  class WebRoutes < Sinatra::Base
    def create_chirp_file
      File.open(ENV['CHIRP_FILE_PATH'], 'w') {}
    end

    def chirp_file_exists?
      File.file?(ENV['CHIRP_FILE_PATH'])
    end

    before do
      create_chirp_file unless chirp_file_exists?
    end

    get '/timeline' do
      use_case = Chirper::UseCase::ViewChirps.new(
        chirp_gateway: chirp_gateway
      )

      chirps = use_case.execute

      chirps.to_json
    end

    post '/create-chirp' do
      use_case = Chirper::UseCase::PostChirp.new(
        chirp_gateway: chirp_gateway
      )

      request_body = JSON.parse(request.body.read.to_s)

      use_case.execute(
        username: request_body['username'],
        body: request_body['body']
      )
    end

    private

    def chirp_gateway
      Chirper::Gateway::FileChirp.new(
        file_path: ENV['CHIRP_FILE_PATH']
      )
    end
  end
end
