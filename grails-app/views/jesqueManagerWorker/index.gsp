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

<div class="row">
    <div class="col-md-12">
        <table id="worker-list-table" class="table table-hover">
            <thead>
            <tr>
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
            {{#each list}}
            <tr>
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
                <td>
                    <a href="javascript: void(0)" data-target="{{name}}" class="remove-worker btn btn-danger"><i class="fa fa-minus-circle"></i> <g:message
                            code="grails.plugin.jesque.manager.view.overview.worker.remove"/></a>
                </td>
            </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>
<script type="text/javascript">
    $(function () {
        var queueListTemplate = Handlebars.compile($("#workers-template").html());

        var intervalId = -1;

        function onFail(){
            if(intervalId != -1){
                clearInterval(intervalId);
                $('#global-danger').text("${g.message(code: 'grails.plugin.jesque.manager.ajax.error')}").removeClass("hidden");
            }
        }

        function refresh() {
            $.ajax("${raw(g.createLink(controller: 'jesqueManagerWorker', action: 'apiHostMap'))}").done(function(data) {
                $('#hostmap').html("");
                for(var key in data.hostmap) {
                    var obj = {name: key,list: data.hostmap[key]};
                    $('#hostmap').append(queueListTemplate(obj));
                }
            }).fail(onFail);
        }
        intervalId = setInterval(refresh, 1000);
        
    });
    $(document).on('mouseup', '.remove-worker', function(event) {
        var $self = $(this);
        var name = $self.data('target');
        if(name != null) {
            $.ajax({
                url: "${raw(g.createLink(controller: 'jesqueManagerWorker', action: 'apiRemove'))}",
                data: {name: name},
                success: function(data) {
                    $self.closest("tr").remove();
                }
            });
        }
    });
</script>
</body>
</html>