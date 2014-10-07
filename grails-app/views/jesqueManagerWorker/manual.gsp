<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <div class="container">
                <h1><g:message code="grails.plugin.jesque.manager.view.worker.manual"/><small><g:message code="grails.plugin.jesque.manager.view.worker.manual.intro"/></small></h1>
            </div>
        </div>
    </div>
</div>
<g:if test="${flash.success}">
    <div class="col-md-12">
        <div class="alert alert-dismissable alert-success">
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <g:message code="grails.plugin.jesque.manager.view.worker.manual.success"/>
        </div>
    </div>
</g:if>

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <g:form action="startWorker" role="form">
            <div class="form-group">
                <g:select id="queueName" name="queueName" from="${queues}" class="form-control"/>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-default"><g:message code="grails.plugin.jesque.manager.view.worker.manual.startWorker"/></button>
            </div>

        </g:form>
    </div>
</div>

</body>
</html>