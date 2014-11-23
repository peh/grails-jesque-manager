<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|  !(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>
        <g:layoutTitle default="${g.message(code: "grails.plugin.jesque.manager.view.title.default")}"/>
    </title>
    <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/handlebars.js/2.0.0/handlebars.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.3/moment-with-locales.min.js"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jesque.css', plugin: 'jesqueManager')}">
    <plugin:isAvailable name="resources">
        <r:layoutResources/>
    </plugin:isAvailable>
    <g:layoutHead/>
</head>

<body>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">

    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
        </div>

        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li class="${controllerName == 'jesqueManager' ? 'active' : ''}">
                    <g:link controller="jesqueManager" action="index">
                        <g:message code="grails.plugin.jesque.manager.nav.index"/>
                    </g:link>
                </li>
                <li class="dropdown ${controllerName == 'jesqueManagerJob' ? 'active' : ''}">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><g:message code="grails.plugin.jesque.manager.nav.jobs"/> <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <g:if test="${grailsApplication.config.grails.jesque.monitoring == true}">
                            <li class="${controllerName == 'jesqueManagerJob' && actionName == 'index' ? 'active' : ''}">
                                <g:link controller="jesqueManagerJob" action="index">
                                    <g:message code="grails.plugin.jesque.manager.nav.jobs.list"/>
                                </g:link>
                            </li>

                            <li class="${controllerName == 'jesqueManagerJob' && actionName == 'manual' ? 'active' : ''}">
                                <g:link controller="jesqueManagerJob" action="manual">
                                    <g:message code="grails.plugin.jesque.manager.nav.jobs.manual"/>
                                </g:link>
                            </li>
                        </g:if>
                        <li class="${controllerName == 'jesqueManagerJob' && actionName == 'failed' ? 'active' : ''}">
                            <g:link controller="jesqueManagerJob" action="failed">
                                <g:message code="grails.plugin.jesque.manager.nav.jobs.failed"/>
                            </g:link>
                        </li>
                        <li class="${controllerName == 'jesqueManagerJob' && actionName == 'triggers' ? 'active' : ''}">
                            <g:link controller="jesqueManagerJob" action="triggers">
                                <g:message code="grails.plugin.jesque.manager.nav.jobs.triggers"/>
                            </g:link>
                        </li>
                        <li class="${controllerName == 'jesqueManagerJob' && actionName == 'delayed' ? 'active' : ''}">
                            <g:link controller="jesqueManagerJob" action="delayed">
                                <g:message code="grails.plugin.jesque.manager.nav.jobs.delayed"/>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <li class="${controllerName == 'jesqueManagerQueue' ? 'active' : ''}">
                    <g:link controller="jesqueManagerQueue" action="index">
                        <g:message code="grails.plugin.jesque.manager.nav.queues"/>
                    </g:link>
                </li>
                <li class="dropdown ${controllerName == 'jesqueManagerWorker' ? 'active' : ''}">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><g:message code="grails.plugin.jesque.manager.nav.workers"/> <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li class="${controllerName == 'jesqueManagerWorker' && actionName == 'index' ? 'active' : ''}">
                            <g:link controller="jesqueManagerWorker" action="index">
                                <g:message code="grails.plugin.jesque.manager.nav.workers.list"/>
                            </g:link>
                        </li>
                        <li class="${controllerName == 'jesqueManagerWorker' && actionName == 'index' ? 'manual' : ''}">
                            <g:link controller="jesqueManagerWorker" action="manual">
                                <g:message code="grails.plugin.jesque.manager.nav.workers.manual"/>
                            </g:link>
                        </li>
                    </ul>
                </li>
                <g:if test="${grailsApplication.config.grails.plugin.jesque.manager.nav.custom}">
                    <g:each in="${grailsApplication.config.grails.plugin.jesque.manager.nav.custom}" var="item">
                        <li class="${controllerName == "jesque${item}" ? 'active' : ''}">
                            <g:link controller="jesque${item}"><g:message code="grails.plugin.jesque.manager.nav.${item.toLowerCase()}"/></g:link>
                        </li>
                    </g:each>
                </g:if>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="javascript: void(0)" id="stop-button" class="hidden"><i class="fa fa-minus-circle"></i></a>
                </li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<div class="container-fluid content">
    <div id="global-danger" class="alert alert-danger hidden" role="alert">
    </div>
    <g:layoutBody/>
</div> <!-- /container -->

<footer class="footer">
    ${g.message(code: "grails.plugin.jesque.manager.view.footer")}
</footer>
<script src="${resource(dir: 'js', file: 'jesque.js', plugin: 'jesqueManager')}"></script>
<plugin:isAvailable name="resources">
    <r:layoutResources/>
</plugin:isAvailable>
</body>
</html>