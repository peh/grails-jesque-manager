package jesque.manager

abstract class AbstractJesqueManagerController {

    def jesqueConfigService
    def jesqueQueuesService
    def jesqueFailureService
    def jesqueWorkersService

    protected void jsonRender(model) {
        render(contentType: 'application/json') {
            model
        }
    }

    protected void sanitizeParams() {
        params.max = params.max ?: 20
        params.offset = params.offset ?: 0
    }
}
