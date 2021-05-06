class Ticket
  attr_accessor :id, :status, :subject, :requester_id, :created_at, :type, :priority, :description, :submitter_id, :updated_at

  def initialize(info)
    @id = info["id"]
    @status = info["status"]
    @subject = info["subject"]
    @requester_id = info["requester_id"]
    @created_at = info["created_at"]
    @type = info["type"]
    @priority = info["priority"]
    @description = info["description"]
    @submitter_id = info["submitter_id"]
    @updated_at = info["updated_at"]
  end
end