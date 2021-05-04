require 'sinatra'
require 'pry'
require 'sinatra/reloader' if settings.development?
require 'httparty'
require_relative '../models/ticket.rb'

class TicketViewer < Sinatra::Application
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


  def show_tickets_list(page_number)
    @page_number = page_number
    @tickets_shown_per_page = 25
    url = "https://alanli.zendesk.com/api/v2/tickets.json?page=#{@page_number}&per_page=#{@tickets_shown_per_page}"

    # res = AuthenticationHelper.make_req_to_api(url)
    
    # @tickets = find_tickets(res)


    # @count = res["count"]
    # @pages = (@count.to_f / @tickets_shown_per_page).ceil
  end



end