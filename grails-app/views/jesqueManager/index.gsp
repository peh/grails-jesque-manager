<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>
        JesqueManager
    </title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jesque.css', plugin: 'jesqueManager')}">
</head>
<body>
<div id="jesque-container"></div>
<script type="application/javascript">
    window.AppSettings = {
        extendedOptions: true,
        root: '/jesque-manager/jesqueManager',
        links: {
            overview: "${g.createLink(controller: 'jesqueManager', action: 'apiOverview')}",
            failed: {
                list: "${g.createLink(controller: 'jesqueManagerJob', action: 'apiFailed')}",
                retry: "${g.createLink(controller: 'jesqueManagerJob', action: 'apiRetry')}",
                retryAll: "${g.createLink(controller: 'jesqueManagerJob', action: 'apiRetryAll')}",
                remove: "${g.createLink(controller: 'jesqueManagerJob', action: 'apiRemove')}",
                removeAll: "${g.createLink(controller: 'jesqueManagerJob', action: 'apiRemoveAll')}"
            }
        }
    }
</script>
<script src="${resource(dir: 'js', file: 'jesque.js', plugin: 'jesqueManager')}"></script>
</body>
</html>
