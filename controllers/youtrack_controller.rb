class ::YoutrackController < ::ApplicationController
  require 'youtrack'

  def create_ticket            
    ticket = NewYoutrackTicket.new(
      ticket_data: {
        project: "BI",        
        discourseid: params[:external_id],
        summary: params[:post_title]        
      },
      post_url: params[:post_url],
      html_comment: params[:html_comment]
    )

    render_ticket_json(ticket)
  end

  def find_ticket
    return render nothing: true unless current_user && current_user.staff?
    ticket = ExistingYoutrackTicket.new(params[:external_id])
    render_ticket_json(ticket)
  end

  def render_ticket_json(ticket)
    if ticket.exists?
      render json: { url: ticket.url, text: ticket.text, title: ticket.title, css_class: ticket.status, exists: true }
    else
      render json: { text: 'Create Youtrack Ticket', title: 'Click to create a new ticket in Youtrack', exists: false }
    end
  end
end