require "youtrack"
class YoutrackTicket
  def initialize(params)
    @client = Youtrack::Client.new do |config|
      c.url =  SiteSetting.youtrack_url
      c.login = SiteSetting.youtrack_user
      c.password = SiteSetting.youtrack_password
    end
  end

  def url
    "#{SiteSetting.youtrack_url}/issue/#{@ticket.id}"
  end

  def status
    @ticket.status
  end

  def text
    # return "View #{status.titleize} Youtrack Ticket"
    return "View Youtrack Ticket"
  end

  def title
    # case status
    #   when "new"      then "Ticket is New. "
    #   when "open"     then "Ticket is Open. "
    #   when "pending"  then "Ticket is Pending. "
    #   when "solved"   then "Ticket has been Solved. "
    #   when "closed"   then "Ticket has been Closed. "
    #   when "hold"     then "Ticket is on Hold. "
    #   else "Ticket status is unknown. "
    # end + "Click to view in Zendesk"
    "Click to view in Youtrack"
  end

  def exists?
    @ticket.present?
  end
end
