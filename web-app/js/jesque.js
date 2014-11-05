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
        var add = $self.data('add');
        var text = "";
        if (time != null) {
            text = moment(new Date(time)).fromNow();
            if(add != null){
                text = text + "(" + add + ")";
            }
            $self.text(text)
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

Handlebars.registerHelper('collectionSize', function (collection) {
    return collection.length;
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

Handlebars.registerHelper('paginate', function (pagination, options) {
    var type = options.hash.type || 'middle';
    var ret = '';
    var pageCount = pagination.pageCount;
    var page = Number(pagination.page);
    var limit;
    if (options.hash.limit) limit = +options.hash.limit;

    //page pageCount
    var newContext = {};
    switch (type) {
        case 'middle':
            if (typeof limit === 'number') {
                var i = 0;
                var leftCount = Math.ceil(limit / 2) - 1;
                var rightCount = limit - leftCount - 1;
                if (page + rightCount > pageCount)
                    leftCount = limit - (pageCount - page) - 1;
                if (page - leftCount < 1)
                    leftCount = page - 1;
                var start = page - leftCount;

                while (i < limit && i < pageCount) {
                    newContext = { n: start };
                    if (start === page) newContext.active = true;
                    ret = ret + options.fn(newContext);
                    start++;
                    i++;
                }
            }
            else {
                for (var i = 1; i <= pageCount; i++) {
                    newContext = { n: i };
                    if (i === page) newContext.active = true;
                    ret = ret + options.fn(newContext);
                }
            }
            break;
        case 'previous':
            if (page === 1) {
                newContext = { disabled: true, n: 1 }
            }
            else {
                newContext = { n: page - 1 }
            }
            ret = ret + options.fn(newContext);
            break;
        case 'next':
            newContext = {};
            if (page === pageCount) {
                newContext = { disabled: true, n: pageCount }
            }
            else {
                newContext = { n: page + 1 }
            }
            ret = ret + options.fn(newContext);
            break;
    }

    return ret;
});