package jesque.manager

abstract class AbstractJesqueManagerController {

    def jesqueConfigService
    def jesqueQueuesService
    def jesqueFailureService
    def jesqueWorkersService

    def afterInterceptor = { model ->
        model.version = jesqueConfigService.version
        model.namespace = jesqueConfigService.namespace
        model.redisUri = jesqueConfigService.uri
    }

    protected void jsonRender(model) {
        render(contentType: 'application/json') {
            model
        }
    }
}
