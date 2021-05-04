require 'sinatra'
require 'pry'
require 'sinatra/reloader' if settings.development?
require 'httparty'
require_relative '../models/ticket.rb'
require_relative '../helpers/authentication_helper.rb'

class TicketViewer < Sinatra::Application

  # route that shows page 1 of tickets list 
  get "/" do
    begin
      page_number = 1
      show_tickets_list(page_number)
      erb(:tickets_list)
    rescue => ex
      @error_message = ex.message
      erb(:error)
    end  
  end

  # route that shows whatever pages
  get "/list/pages/:page_number" do
    begin
      page_number = params[:page_number]
      show_tickets_list(page_number)
      erb(:tickets_list)
    rescue => ex
      @error_message = ex.message
      erb(:error)
    end
  end

  # function to make requests of showing whatever pages
  def show_tickets_list(page_number)
    @page_number = page_number
    @tickets_shown_per_page = 25
    url = "https://alanli.zendesk.com/api/v2/tickets.json?page=#{@page_number}&per_page=#{@tickets_shown_per_page}"

    res = AuthenticationHelper.make_req_to_api(url)
    @tickets = find_tickets(res)
    @count = res["count"]
    @pages = (@count.to_f / @tickets_shown_per_page).ceil
  end

  # form an array of tickets found, each element is a ticket instance created using Ticket model
  def find_tickets(res)
    if res.key?("tickets")
      tickets_info = res["tickets"]
      @tickets = []
      tickets_info.each do |ticket_info|
        ticket = Ticket.new(ticket_info)
        @tickets << ticket
      end
      @tickets
    elsif res.key?("error")
      raise res["error"]
    else
      raise "unknown error from API"
    end
  end

end