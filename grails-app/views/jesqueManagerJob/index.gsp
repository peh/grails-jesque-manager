<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div class="row">
    <div class="col-md-12">
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
</div>
<script id="queue-list-template" type="text/x-handlebars-template">
{{#each queues}}
<tr>
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
<tr>
    <td>
        <g:message code="grails.plugin.jesque.manager.jobs.failed.label"/>
    </td>
    <td>
        {{count}}
    </td>
</tr>
</script>

<g:javascript>
    $(function () {
        var $queueListTable = $('#queue-list-table');

        var queueListTemplate = Handlebars.compile($("#queue-list-template").html());
        var failedTemplate = Handlebars.compile($("#failed-template").html());

        var intervalId = -1;

        function onFail(){
            if(intervalId != -1){
                clearInterval(intervalId);
                $('#global-danger').text("${g.message(code: 'grails.plugin.jesque.manager.ajax.error')}")
            }
        }

        function refresh() {
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerQueue', action: 'apiNames'))}").done(function(data) {
                $queueListTable.find('tbody').html(queueListTemplate(data));
            }).fail(onFail);
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerJob', action: 'apiFailedCount'))}").done(function(data) {
                $queueListTable.find('tfoot').html(failedTemplate(data));
            }).fail(onFail);
        }
        intervalId = setInterval(refresh, 1000)

    });
</g:javascript>
</body>
</html>