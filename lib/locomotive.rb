# frozen_string_literal: true

require 'zeitwerk'
require 'forwardable'

require_relative 'locomotive/version'
require_relative 'locomotive/configuration'
require_relative 'locomotive/api'
require_relative 'locomotive/request'

module Locomotive
  class App
    Config = Locomotive::Configuration.new
    PathLoader = Zeitwerk::Loader.new do |l|
      Config.autoload_paths.each { |path| l.push_dir(path) }
      l.enable_reloading if Config.development?
    end
    Middleware = [].tap do |middleware|
      middleware << [Rack::Reloader, 0] if Config.development?
    end

    class << self
      def environment
        Config.environment
      end

      def root
        Config.root
      end

      def development?
        Config.development?
      end

      def middleware
        Middleware + Config.middleware
      end

      def configure
        yield Config
      end

      def launch
        $LOAD_PATH.unshift(root)
        yield middleware
        new
      end
    end

    def call(env)
      PathLoader.setup
      Locomotive::Request.new(env).process
    end
  end
end
