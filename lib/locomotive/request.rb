module Locomotive
  class Request
    attr_reader :raw

    def initialize(env)
      @raw = env
      *@raw_path, @action = @raw['REQUEST_PATH'].split('/')
      @path = []
      @params = {}
    end

    def process
      process_path
      api.new(@action, self).call
    end

    private

    def api
      Object.const_get("::#{@path.join('::')}")
    rescue NameError => e
      p e
    end

    def process_path
      # TODO: Verify url decoding...
      last_descriptor = nil
      @raw_path.shift

      Array(@raw_path).each_with_index.map do |segment, idx|
        if idx.even?
          last_descriptor = "#{segment.downcase}_id"
          api_name = segment.gsub(/(_|-)[a-z]/) { |m| m[1].capitalize }
          @path << "#{api_name.capitalize}Api"
        else
          @params[last_descriptor] = segment
        end
      end
    end

    def method
      @raw['REQUEST_METHOD'].downcase
    end
  end
end
