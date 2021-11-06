# TODO:
# Object/Kernel - Add constantize method (Support)
# String Camelize (Support)
# Logger Implementation
# Clean the middleware addition

require 'pry'
require 'locomotive'

require_relative 'app'
require_relative 'config/shared'
require_relative "config/#{App.environment}"

app = App.launch do |middleware|
  middleware.each { |m, params| use m, *params }
end

run app
