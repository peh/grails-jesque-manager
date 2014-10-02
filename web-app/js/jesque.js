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