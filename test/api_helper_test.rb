require_relative '../helpers/api_helper.rb'
require 'minitest/autorun'
require 'minitest/reporters' # optional
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new) # optional

class ApiHelperTest < MiniTest::Unit::TestCase
  def test_valid_response_for_tickets
    url = "https://alanli.zendesk.com/api/v2/tickets.json?page=1&per_page=25"
    assert_equal true, ApiHelper.make_req_to_api(url).key?("tickets")
  end

  def test_valid_response_for_single_ticket_details
    url = "https://alanli.zendesk.com/api/v2/tickets/1.json"
    assert_equal true, ApiHelper.make_req_to_api(url).key?("ticket")
  end

  def test_valid_response_for_requester_name
    url = "https://alanli.zendesk.com/api/v2/users/902093503063.json"
    assert_equal true, ApiHelper.make_req_to_api(url).key?("user")
  end

  # try to authenticate another trial account of mine
  def test_couldnot_authenticate
    url = "https://lialan.zendesk.com/api/v2/tickets.json"
    assert_equal true, ApiHelper.make_req_to_api(url).key?("error")
  end
end