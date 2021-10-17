module Locomotive
  class Api
    # TODO: callbacks, response rendering and headers, error handling, http responses, content negotiation
    attr_reader :action, :request

    class << self
      @callbacks = { before: [], after: [] }
    end

    def initialize(action, request)
      @action = action
      @request = request
    end

    def respond_with(body, status: 200)
      [status, headers, body]
    end

    def headers
      { 'Content-Type' => 'application/json' }
    end

    def call
      public_send(action)
    end
  end
end
