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
                    <g:message code="grails.plugin.jesque.manager.view.overview.jobs.name"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${jobs}" var="job">
                <tr class="clickable" data-target="${g.createLink(controller: 'jesqueManagerJob', action: 'details', id: job)}">
                    <td>
                        ${job}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>