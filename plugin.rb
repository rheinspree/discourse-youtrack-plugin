# name: youtrack
# about: create and view status of youtrack ticket within a topic
# version: 0.0.1
# authors: Sebastian Brandt
enabled_site_setting :youtrack_uri
enabled_site_setting :youtrack_user
enabled_site_setting :youtrack_password
enabled_site_setting :youtrack_project
enabled_site_setting :youtrack_topic

gem 'youtrack', '0.0.11'

register_asset "javascripts/topic_route_cont.js"
register_asset "javascripts/youtrack_button.js"
register_asset "stylesheets/buttons_cont.css.scss"

after_initialize do
  load File.expand_path("../controllers/youtrack_controller.rb", __FILE__)
  load File.expand_path("../lib/youtrack_ticket.rb", __FILE__)
  load File.expand_path("../lib/new_youtrack_ticket.rb", __FILE__)
  load File.expand_path("../lib/existing_youtrack_ticket.rb", __FILE__)

  Discourse::Application.routes.prepend do
    post 'youtrack/create_ticket' => 'youtrack#create_ticket'
    get 'youtrack/find_ticket' => 'youtrack#find_ticket'
  end
end
