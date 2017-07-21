import Category from 'discourse/models/category';
import User from 'discourse/models/user';

export default {
    name: 'topic-controller-youtrack',

    initialize(container) {

        const TopicController = container.lookupFactory('controller:topic');
        TopicController.reopen({
            youtrackTicket: {
                text: 'Create Youtrack Ticket',
                title: 'Click to create a new ticket in Youtrack',
                exists: false
            },

            actions: {
                sendToYoutrack(posts, currentUser, topicCreatorUsername) {
                    var topicController = this,
                        post = posts.shift(),
                        title = post.topic.title,
                        bodyAsHtml = post.cooked,
                        createdAt = post.created_at,
                        topicId = post.topic_id,
                        categoryId = post.topic.category_id,
                        topicSlug = post.topic_slug,
                        collaboratorEmail = false,
                        requesterInfo = false,
                        categoryName = false;

                    var makeAjaxCall = function() {
                        if (collaboratorEmail && requesterInfo && categoryName) {
                            return Discourse.ajax("/youtrack/create_ticket", {
                                dataType: 'json',
                                data: {
                                    post_title: title,
                                    html_comment: bodyAsHtml,
                                    created_at: createdAt,
                                    requester: requesterInfo,
                                    collaborator_email: collaboratorEmail,
                                    category_name: categoryName,
                                    external_id: topicSlug + topicId,
                                    post_url: window.location.href
                                },
                                type: 'POST'
                            }).then(function(ticket) {
                                topicController.setProperties({ youtrackTicket: ticket });
                            });
                        }
                    };

                    User.findByUsername(currentUser.get('username')).then(function(currentUser) {
                        collaboratorEmail = currentUser.get('email');
                    }).then(makeAjaxCall);

                    User.findByUsername(topicCreatorUsername).then(function(topicCreator) {
                        requesterInfo = { name: topicCreator.get('name'), email: topicCreator.get('email') };
                    }).then(makeAjaxCall);

                    Category.reloadById(categoryId).then(function(data) {
                        categoryName = data.category.name;
                    }).then(makeAjaxCall);
                },

                redirectToYoutrack: function(url) { window.open(url); }
            }
        });
    }
}