module Locomotive
  class Request
    attr_reader :raw

    def initialize(env)
      @raw = env
    end

    def process
      api_name, action = path.split('/')
      api = Object.get_const("#{api_name.camelize}Api")
      api.new(action, self).call
    end

    private

    def method
      @raw['REQUEST_METHOD'].downcase
    end

    def path
      @raw['REQUEST_PATH']
    end
  end
end
