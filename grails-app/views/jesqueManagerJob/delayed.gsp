<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <table id="job-list-table" class="table table-hover">
            <thead>
            <tr>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.delayed.time"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.delayed.name"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.delayed.queue"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.overview.delayed.args"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${jobs}" var="job">
                <tr class="clickable" data-target="${g.createLink(controller: 'jesqueManagerJob', action: 'details', id: job)}">
                    <td class="fromNow" data-time="${job.time}">
                        ${job}
                    </td>
                    <td>
                        ${job.class}
                    </td>
                    <td>
                        ${job.queue}
                    </td>
                    <td>
                        ${job.queue}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>