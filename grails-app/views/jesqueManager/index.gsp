<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
    <plugin:isAvailable name="resources">
        <r:layoutResources/>
    </plugin:isAvailable>
</head>

<body>
<div class="row">
    <div class="col-md-6">
        <table id="queue-list-table" class="table table-hover">
            <thead>
            <tr>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.queues.name"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.queues.size"/>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
            </tfoot>
        </table>
    </div>

    <div class="col-md-6">
        <table id="worker-list-table" class="table table-hover">
            <thead>
            <tr>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.worker.host"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.worker.pid"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.worker.state"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.worker.processed"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.worker.failed"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.worker.queues"/>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<script id="queue-list-template" type="text/x-handlebars-template">
{{#each queues}}
<tr class="clickable" data-target="${raw(g.createLink(controller: 'jesqueManagerJob', action: 'details'))}/{{name}}">
    <td>
        {{name}}
    </td>
    <td>
        {{size}}
    </td>
</tr>
{{/each}}
</script>
<script id="failed-template" type="text/x-handlebars-template">
<tr class="clickable {{#if danger}}danger{{else}}success{{/if}}" data-target="${raw(g.createLink(controller: 'jesqueManagerJob', action: 'failed'))}">
    <td>
        <g:message code="grails.plugin.jesque.manager.jobs.failed.label"/>
    </td>
    <td>

        {{count}}
    </td>
</tr>
</script>

<script id="worker-list-template" type="text/x-handlebars-template">
{{#each workers}}
<tr>
    <td>
        {{host}}
    </td>
    <td>
        {{pid}}
    </td>
    <td>
        {{state.name}}
    </td>
    <td>
        {{processed}}
    </td>
    <td>
        {{failed}}
    </td>
    <td>
        {{queues}}
    </td>
</tr>
{{/each}}
</script>
<script type="text/javascript">
    $(function () {
        var $queueListTable = $('#queue-list-table');
        var $workerListTable = $('#worker-list-table');

        var queueListTemplate = Handlebars.compile($("#queue-list-template").html());
        var workerListTemplate = Handlebars.compile($("#worker-list-template").html());
        var failedTemplate = Handlebars.compile($("#failed-template").html());

        var intervalId = -1;

        function onFail() {
            if (intervalId != -1) {
                clearInterval(intervalId);
                $('#global-danger').text("${g.message(code: 'grails.plugin.jesque.manager.ajax.error')}").removeClass("hidden");
            }
        }

        function refresh() {
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerQueue', action: 'apiQueues'))}").done(function (data) {
                $queueListTable.find('tbody').html(queueListTemplate(data));
            }).fail(onFail);
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerWorker', action: 'apiWorkers'))}").done(function (data) {
                $workerListTable.find('tbody').html(workerListTemplate(data));
            }).fail(onFail);
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerJob', action: 'apiFailedCount'))}").done(function (data) {
                data["danger"] = data.count > 0;
                $queueListTable.find('tfoot').html(failedTemplate(data));
            }).fail(onFail);
        }

        intervalId = setInterval(refresh, 1000)
    });
</script>
<plugin:isAvailable name="resources">
    <r:layoutResources/>
</plugin:isAvailable>
</body>
</html>