class Ticket
  attr_accessor :id, :subject, :description, :requester_id,    :submitter_id, :requester_name

  def initialize(info)
    @id = info["id"]
    @subject = info["subject"]
    @description = info["description"]
    @submitter_id = info["submitter_id"]
    @requester_id = info["requester_id"]
  end
end