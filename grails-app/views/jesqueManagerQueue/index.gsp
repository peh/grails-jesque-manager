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
                    <g:message code="grails.plugin.jesque.manager.view.queue.name"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.queue.size"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${list}" var="queue">
                <tr class="clickable" data-target="${g.createLink(controller: 'jesqueManagerQueue', action: 'details', id: queue.name)}">
                    <td>
                        ${queue.name}
                    </td>
                    <td>
                        ${queue.size}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>

<script id="queue-list-template" type="text/x-handlebars-template">
{{#each queues}}
<tr class="clickable" data-target="${raw(g.createLink(controller: 'jesqueManagerQueue', action: 'details'))}/{{name}}">
    <td>
        {{name}}
    </td>
    <td>
        {{size}}
    </td>
</tr>
{{/each}}
</script>
<script type="text/javascript">
    $(function () {
        var $queueListTable = $('#queue-list-table');

        var queueListTemplate = Handlebars.compile($("#queue-list-template").html());

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
        }

        intervalId = setInterval(refresh, 1000)
    });
</script>

</body>
</html>