<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <table class="table table-striped stable-hover">
            <thead>
            <tr>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.name"/></th>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.expression"/></th>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.next"/></th>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.queue"/></th>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.job"/></th>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.args"/></th>
                <th><g:message code="grails.plugin.jesque.manager.jobs.triggers.remove"/></th>
            </tr>
            </thead>
            <tbody>
            <g:if test="${!scheduledJobs}">
                <tr>
                    <td colspan="7" class="no-data"><g:message code="grails.plugin.jesque.manager.jobs.triggers.none"/></td>
                </tr>
            </g:if>
            <g:each in="${scheduledJobs}" var="scheduledJob">
                <tr>
                    <td>
                        ${scheduledJob.name}
                    </td>
                    <td>
                        ${scheduledJob.cronExpression}
                    </td>
                    <td class="fromNow" data-time="${scheduledJob.trigger.nextFireTime.millis}">
                        ${scheduledJob.trigger.nextFireTime}
                    </td>
                    <td>
                        ${scheduledJob.jesqueJobQueue}
                    </td>
                    <td>
                        ${scheduledJob.jesqueJobName}
                    </td>
                    <td>
                        ${scheduledJob.args}
                    </td>
                    <td>
                        <a href='javascript: remove("${scheduledJob.name}")' class="btn btn-danger">
                            <i class="fa fa-minus-circle"></i> <g:message code="grails.plugin.jesque.manager.jobs.triggers.remove"/></a>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
<g:javascript>
    function remove(name){
        $.ajax({
            url: "${raw(g.createLink(controller: 'jesqueManagerJob', action: 'apiDeleteTrigger'))}",
                data: {name: name},
                success: function(data) {
                    window.location.reload();
                }
        });
    }
</g:javascript>
</body>
</html>