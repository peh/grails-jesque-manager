<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <meta name="layout" content="jesque"/>
</head>

<body>
<div class="row">
    <div class="col-md-2 col-md-offset-10">
        <g:link controller="jesqueManagerJob" action="retryAll" class="btn btn-warning"><i class="fa fa-repeat"></i> <g:message
                code="grails.plugin.jesque.manager.view.jobs.failed.retryAll"/></g:link>
        <g:link controller="jesqueManagerJob" action="clear" class="btn btn-danger"><i class="fa fa-trash"></i> <g:message
                code="grails.plugin.jesque.manager.view.jobs.failed.removeAll"/></g:link>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <table id="failed-table" class="table table-hover">
            <thead>
            <tr>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.jobs.failed.job"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.jobs.failed.failedAt"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.jobs.failed.exceptionString"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.jobs.failed.retry"/>
                </th>
                <th>
                    <g:message code="grails.plugin.jesque.manager.view.jobs.failed.remove"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${list}" var="item" status="i">
                <tr class="clickable" data-get="${raw(g.createLink(controller: 'jesqueManagerJob', action: 'apiGet', id: params.offset + i))}">
                    <td>
                        ${item.payload.className}
                    </td>
                    <td class="fromNow" data-time="${item.failedAt.time}">

                    </td>
                    <td>
                        ${item.throwableString}
                    </td>
                    <td>
                        <g:if test="${item.retriedAt}">
                            <g:message code="grails.plugin.jesque.manager.view.jobs.failed.retriedAt"/>: <span class="format" data-time="${item.retriedAt.time}"></span>
                        </g:if>
                        <g:else>
                            <g:link controller="jesqueManagerJob" action="requeue" id="${params.offset + i}" class="btn btn-warning btn-sm"><i class="fa fa-repeat"></i></g:link>
                        </g:else>
                    </td>
                    <td>
                        <g:link controller="jesqueManagerJob" action="remove" id="${params.offset + i}" class="btn btn-danger btn-sm"><i class="fa fa-trash"></i></g:link>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <jesque:paginate total="${total}" max="20"/>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <section id="failed-details">

        </section>
    </div>
</div>
<script id="failed-details-template" type="text/x-handlebars-template">
<dl class="dl-horizontal">
    <dt><g:message code="grails.plugin.jesque.manager.view.jobs.failed.job"/></dt>
    <dd>{{payload.className}}</dd>
    <dt><g:message code="grails.plugin.jesque.manager.view.jobs.failed.failedAt"/></dt>
    <dd>{{fromNow failedAt}} ({{format failedAt}})</dd>
    <dt><g:message code="grails.plugin.jesque.manager.view.jobs.failed.exception"/></dt>
    <dd>{{error}}</dd>
    <dt><g:message code="grails.plugin.jesque.manager.view.jobs.failed.exceptionString"/></dt>
    <dd>{{throwableString}}</dd>
    <dt><g:message code="grails.plugin.jesque.manager.view.jobs.failed.stacktrace"/></dt>
    <dd>
        {{#each backtrace}}
        {{this}} <br/>
        {{/each}}
    </dd>
</dl>
</script>
<g:javascript>
    $(function () {
        var $details = $('#failed-details');
        var detailsTemplate = Handlebars.compile($("#failed-details-template").html());

        $('.clickable').click(function () {
            $('#failed-table > tbody > tr').each(function () {
                $(this).removeClass("info");
            });
            var $self = $(this);
            $self.addClass('info');
            $('html,body').animate({
                scrollTop: $details.offset().top
            }, 300);
            $details.html('<i class="fa fa-spinner fa-spin"></i>');
            $.ajax($self.data('get')).done(function (data) {
                $details.html(detailsTemplate(data.failure));
            });
        });
    });
</g:javascript>
</body>
</html>