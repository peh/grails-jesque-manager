<%--
  Created by IntelliJ IDEA.
  User: peh-mbp
  Date: 06/10/14
  Time: 13:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="jesque">
</head>

<body>
<div class="row">
    <div class="col-md-12">
        <table class="table table-condensed table-striped table-hover">
            <thead>
            <tr>
                <g:sortableColumn property="start" titleKey="grails.plugin.jesque.manager.jobs.details.start"/>
                <g:sortableColumn property="runtime" titleKey="grails.plugin.jesque.manager.jobs.details.runtime"/>
                <th>
                    <g:message code="grails.plugin.jesque.manager.jobs.details.args"/>
                </th>
            </tr>
            </thead>
            <tbody id="jobs">
            <g:each in="${list.list}" var="job">
                <tr class="${!Boolean.parseBoolean(job.success) ? 'danger' : ''}">
                    <td class="fromNow" data-time="${job.start}" data-add="${g.formatDate(date: new Date(job.start? job.start as Long : 0L), type:"datetime", style:"LONG")}">
                        ${job.start}
                    </td>
                    <td>
                        ${job.runtime}
                    </td>
                    <td>
                        ${job.args}
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <jesque:paginate total="${list.total}" max="20" params="${params}"/>
    </div>
</div>
</body>
</html>