Discourse.YoutrackButton = Discourse.ButtonView.extend({
    rerenderTriggers: ['controller.youtrackTicket.exists'],

    classNames: ['youtrack'],
    classNameBindings: ['controller.youtrackTicket.css_class'],
    titleBinding: 'controller.youtrackTicket.title',
    textBinding: 'controller.youtrackTicket.text',

    click() {
        if (this.get('controller.youtrackTicket.exists')) {
            this.get('controller').send('redirectToYoutrack', this.get('controller.youtrackTicket.url'));
        } else {
            this.get('controller').send('sendToYoutrack', this.get('controller.model.postStream.posts'), this.get('controller.currentUser'), this.get('controller.model.postStream.firstLoadedPost.username'));
        }
    },

    renderIcon(buffer) {
        buffer.push("<i class='fa fa-ticket'></i>");
    }
});

Discourse.TopicFooterButtonsView.reopen({
    addYoutrackButton: function() {
        if (this.get('controller.currentUser.staff')) {
            this.attachViewClass(Discourse.YoutrackButton);
        }
    }.on("additionalButtons")
});