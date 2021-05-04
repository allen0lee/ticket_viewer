require 'sinatra'
require 'pry'
require 'sinatra/reloader' if settings.development?
require 'httparty'
require_relative '../models/ticket.rb'

class TicketViewer < Sinatra::Application
  get "/" do

    p 'hello 1'
    # binding.pry
    erb(:error)
  end

end