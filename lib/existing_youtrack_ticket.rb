class ExistingYoutrackTicket < YoutrackTicket
  def initialize(existing_id)
    super
    @ticket = @client.list ({:filter => existing_id, :with => "DiscourseId"}).to_a.try(:first)
  end
end