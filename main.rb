require 'sinatra'
require 'sinatra/reloader' if settings.development?
require_relative 'controllers/tickets_controller.rb'

class TicketViewer < Sinatra::Application
end

