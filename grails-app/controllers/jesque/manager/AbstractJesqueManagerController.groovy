package jesque.manager

abstract class AbstractJesqueManagerController {

    def jesqueConfigService
    def jesqueManagerService
    def jesqueQueuesService
    def jesqueFailureService
    def jesqueWorkersService
    def jesqueService
    def jesqueScheduledService
    def grailsApplication

    protected void jsonRender(model) {
        render(contentType: 'application/json') {
            model
        }
    }

    def beforeInterceptor = {
        if(!grailsApplication.config.grails.jesque.enabled) {
            render "Jesque is disabled!"
            return false
        }
    }

    protected void sanitizeParams() {
        params.max = params.max ?: 20
        params.offset = params.offset ?: 0
    }
}
