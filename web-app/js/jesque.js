$(document).on('mouseup', '.clickable', function (event) {
    if (event.target.nodeName == 'TD' && $(this).data('target')) {
        var target = $(this).data('target');
        if (event.metaKey || event.ctrlKey || event.which === 2) {
            window.open(target);
        } else {
            window.location = target;
        }
    }
});

$(function () {
    $('.fromNow').each(function () {
        var $self = $(this);
        var time = $self.data('time');
        if (time != null) {
            $self.text(moment(new Date(time)).fromNow());
        }
    });

    $('.format').each(function () {
        var $self = $(this);
        var time = $self.data('time');
        if (time != null) {
            $self.text(moment(new Date(time)).format('DD.MM.YY, HH:mm:ss'));
        }
    });
});

Handlebars.registerHelper('fromNow', function (date) {
    if (date instanceof String)
        date = new Date(date);
    return moment(date).fromNow();
});

Handlebars.registerHelper('format', function (date) {
    if (date instanceof String)
        date = new Date(date);
    return moment(date).format('DD.MM.YY, HH:mm:ss.SSS');
});