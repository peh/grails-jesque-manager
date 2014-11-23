<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div id="hostmap">

</div>

<script id="workers-template" type="text/x-handlebars-template">
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h4>{{name}}</h4>
        </div>
    </div>
</div>
{{#each list}}
<div class="row mtopten bbotgray">
    <div class="col-md-10">
        <dl id="{{name}}">
            <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.pid"/></dt>
            <dd>{{pid}}</dd>
            <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.state"/></dt>
            <dd>{{state.name}}</dd>
            <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.processed"/></dt>
            <dd>{{processed}}</dd>
            <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.failed"/></dt>
            <dd>{{failed}}</dd>
            {{#if status}}
                <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.working.job"/></dt>
                <dd>{{status.payload.className}}</dd>
                <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.working.args"/></dt>
                <dd>{{#if status.payload.args}}{{status.payload.args}}{{else}}-{{/if}}</dd>
                <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.working.since"/></dt>
                <dd>{{fromNow status.runAt}} ({{format status.runAt}})</dd>
            {{/if}}
            <dt><g:message code="grails.plugin.jesque.manager.view.overview.worker.queues"/></dt>
            <dd>{{queues}}</dd>
        </dl>
    </div>
    <div class="col-md-2">
        <a href="javascript: void(0)" data-target="{{name}}" class="remove-worker btn btn-danger">
            <i class="fa fa-minus-circle"></i> <g:message code="grails.plugin.jesque.manager.view.worker.remove"/>
        </a>
    </div>
</div>
{{/each}}
</script>
<script type="text/javascript">

    var intervalId = -1;
    $(function () {

        var $root = $('#hostmap');

        var queueListTemplate = Handlebars.compile($("#workers-template").html());

        function onFail() {
            if (intervalId != -1) {
                clearInterval(intervalId);
                $('#global-danger').text("${g.message(code: 'grails.plugin.jesque.manager.ajax.error')}").removeClass("hidden");
            }
            $('#stop-button').removeClass('fa-spin');
        }

        function refresh() {
            $('#stop-button').addClass('fa-spin');
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerWorker', action: 'apiHostMap'))}").done(function (data) {
                $root.empty();
                for (var key in data.hostmap) {
                    var obj = {name: key, list: data.hostmap[key]};
                    $root.append(queueListTemplate(obj));
                }
            }).fail(onFail);
        }

        intervalId = setInterval(refresh, 1000);
        $('#stop-button').removeClass("hidden").click(function () {
            clearInterval(intervalId);
            $('#stop-button').removeClass('fa-spin');
        })

    });
    $(document).on('mouseup', '.remove-worker', function (event) {
        var $self = $(this);
        var name = $self.data('target');
        if (name != null) {
            $.ajax({
                url: "${raw(g.createLink(controller: 'jesqueManagerWorker', action: 'apiRemove'))}",
                data: {name: name},
                success: function (data) {
                    $self.closest("tr").remove();
                }
            });
        }
    });
</script>
</body>
</html>