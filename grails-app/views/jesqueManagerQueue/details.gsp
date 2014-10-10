<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div class="row">
    <div class="col-md-6">
        <dl>
            <dt><g:message code="grails.plugin.jesque.manager.view.queue.name"/></dt>
            <dd>${queue.name}</dd>
            <dt><g:message code="grails.plugin.jesque.manager.view.queue.size"/></dt>
            <dd>${queue.size}</dd>
        </dl>
    </div>

    <div class="col-md-6">

        <g:link controller="jesqueManagerQueue" action="remove" id="${queue.name}"
                onclick="return confirm('${g.message(code: "grails.plugin.jesque.manager.queue.remove.confirm")}')"
                class="btn btn-danger">
            ${g.message(code: "grails.plugin.jesque.manager.queue.remove")}
        </g:link>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <g:message code="grails.plugin.jesque.manager.view.queue.jobs"/>
        <table class="table table-condensed table-striped table-hover">
            <thead>
            <tr>
                <th>
                    <g:message code="grails.plugin.jesque.manager.jobs.details.name"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.jobs.details.args"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${queue.jobs}" var="job">
                <tr>
                    <td>
                        ${job.className}
                    </td>
                    <td>
                        ${job.args as List}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>