# frozen_string_literal: true

module Locomotive
  class Configuration
    attr_writer :autoload_paths, :middleware

    def root
      @root ||= File.expand_path('.')
    end

    def autoload_paths
      @autoload_paths ||= []
    end

    def middleware
      @middleware ||= []
    end

    def development?
      environment == :development
    end

    def environment
      @environment ||= ENV['RACK_ENV'].to_sym || :development
    end
  end
end
