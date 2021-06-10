require 'sinatra'
require 'sinatra/cross_origin'
require 'pry'
require 'sinatra/reloader' if settings.development?
require 'httparty'
require_relative '../models/ticket.rb'
require_relative '../helpers/api_helper.rb'

class TicketViewer < Sinatra::Application
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  # endpoint that gives json for whatever page
  get "/tickets_list/page/:page_number" do
    begin
      page_number = params[:page_number]
      @tickets, @count, @pages = show_tickets_list(page_number)
      # erb(:tickets_list)
      content_type :json
      {
        "tickets"=> @tickets.map{|x|
          {
            "id"=> x.id,
            "status"=> x.status,
            "subject"=> x.subject,
            # "requester"=> get_user_name(x.requester_id),
            "requested"=> x.created_at
          }
        },
        "pages"=> @pages,
        "count"=> @count
      }.to_json 
      
    rescue => ex
      @error_message = ex.message
      # erb(:error)
      content_type :json
      {
        "error"=> @error_message
      }.to_json 
    end
  end

  # endpoint that gives json for single ticket details
  get "/ticket/:ticket_id" do
    begin
      ticket_id = params[:ticket_id]
      @ticket = show_ticket_details(ticket_id)
      # erb(:ticket_details)
      content_type :json
      {
        "ticket"=> 
          {
            "id"=> @ticket.id,
            "status"=> @ticket.status,
            "subject"=> @ticket.subject,
            "description"=> @ticket.description,
            "requester"=> @ticket.requester_name,
            "requested"=> @ticket.created_at
          }
      }.to_json 

    rescue => ex
      @error_message = ex.message
      # erb :error
      content_type :json
      {
        "error"=> @error_message
      }.to_json 
    end
  end

  # function to make requests of showing whatever page
  def show_tickets_list(page_number)
    @tickets_shown_per_page = 25
    url = "https://alanli1.zendesk.com/api/v2/tickets.json?page=#{page_number}&per_page=#{@tickets_shown_per_page}"

    res = ApiHelper.make_req_to_api(url)
    @tickets = find_tickets(res)
    @count = res["count"]
    @pages = (@count.to_f / @tickets_shown_per_page).ceil
    return @tickets, @count, @pages
  end

  # form an array of tickets found, each element is a ticket instance created by Ticket model, using ticket data from the Zendesk API
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

  # function to make requests of showing single ticket details
  def show_ticket_details(ticket_id)
    url = "https://alanli1.zendesk.com/api/v2/tickets/#{ticket_id}.json"

    res = ApiHelper.make_req_to_api(url)
    @ticket = find_ticket_details(res)
    @ticket.requester_name = get_user_name(@ticket.requester_id)
    return @ticket
  end

  def find_ticket_details(res)
    if res.key?("ticket")
      ticket_info = res["ticket"]
      ticket = Ticket.new(ticket_info)
    elsif res.key?("error")
      raise res["error"]
    else
      raise "unknown error from API"
    end
  end

  def get_user_name(requester_id)
    url = "https://alanli1.zendesk.com/api/v2/users/#{requester_id}.json"
    res = ApiHelper.make_req_to_api(url)
    if res.key?("user")
      name = res["user"]["name"]
    elsif res.key?("error")
      raise res["error"]
    else
      raise "unknown error from API"
    end
  end

end