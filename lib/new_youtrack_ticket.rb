class NewYoutrackTicket < YoutrackTicket
  def initialize(params)
    super
    @url = params[:post_url]
    @html_comment = params[:html_comment]
    @comment = format_comment
    @ticket = @client.issues.create(params[:ticket_data].merge(additional_data))
  end

  private

  def format_comment
    body_to_text = Nokogiri::HTML(@html_comment).text
    return "Link to forum topic:\n#{@url}\n\nComment:\n#{body_to_text}"
  end

  def additional_data
    { :description =>  @comment }
  end
end
