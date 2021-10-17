require_relative '../lib/locomotive'
require 'rack/test'
require 'pry'

describe Locomotive::Application do
  include Rack::Test::Methods

  let(:app) { described_class.new }
  subject(:response) { last_response }

  context 'Call app on root path' do
    before { get '/' }

    it { expect(response.ok?).to be true }
    it { expect(response.body).to eq 'Ready to plug!' }
  end
end
