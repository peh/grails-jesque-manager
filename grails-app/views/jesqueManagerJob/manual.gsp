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
                <h1><g:message code="grails.plugin.jesque.manager.jobs.manual"/><small><g:message code="jesque.web.jobs.manual.intro"/></small></h1>
            </div>
        </div>
    </div>
</div>

<g:if test="${flash.success}">
    <div class="row">
        <div class="col-md-12">
            <div class="container">
                <div class="alert alert-dismissable alert-success">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <g:message code="jesque.web.job.manual.success"/> - ${selectedJob}
                </div>
            </div>
        </div>
    </div>
</g:if>

<div class="row">
    <div class="col-md-8 col-md-offset-2">
        <g:form controller="jesqueManagerJob" action="enqueue" class="form manual-form" role="form">
            <div class="form-group">
                <g:select name="jobName" from="${jobs}" class="form-control" value="${selectedJob}"/>
            </div>

            <div id="attribs-container">
                <div class="form-group">
                    <input class="form-control" name="attrib[]" type="text" data-type="autoadd" data-remove="#initial"/>
                </div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-default"><g:message code="jesque.web.jobs.manual.enqueue"/></button>
            </div>
        </g:form>
    </div>
</div>
<script id="attrib-input" type="text/x-handlebars-template">
<div class="form-group" id="{{identifier}}">
    <input class="form-control" name="attrib[]" type="text" data-type="autoadd" data-remove="#{{identifier}}"/>
</div>
</script>

<script type="text/javascript">
    $(function () {
        var template = Handlebars.compile($("#attrib-input").html());
        var $container = $('#attribs-container');
        $(document).on("focusout", "form.manual-form input[data-type=autoadd]", function () {
            var $this = $(this);

            if(!$this.val()){
                $($this.data('remove')).remove();
            }
        });
        $(document).on("keyup", "form.manual-form input[data-type=autoadd]", function () {
            var $this = $(this);
            var $all = $("form.manual-form input[data-type=autoadd]");
            if ($all.last().val() && $this.val()) {
                $container.append(template({identifier: Math.random().toString(36).substring(7)}));
            }
        });
    });
</script>
</body>
</html>