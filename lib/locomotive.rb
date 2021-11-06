# frozen_string_literal: true

require 'zeitwerk'

require_relative 'locomotive/version'
require_relative 'locomotive/configuration'
require_relative 'locomotive/api'
require_relative 'locomotive/request'

module Locomotive
  class App
    Config = Locomotive::Configuration.new
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

      def loader
        @loader ||= Zeitwerk::Loader.new.tap do |l|
          Config.autoload_paths.each { |path| l.push_dir(path) }
          l.enable_reloading if Config.development?
        end
      end

      def launch
        $LOAD_PATH.unshift(root)
        yield middleware
        new
      end
    end

    def call(env)
      App.loader.setup
      Locomotive::Request.new(env).process
    end
  end
end
