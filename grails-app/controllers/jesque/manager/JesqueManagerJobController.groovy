package jesque.manager

import grails.plugin.jesque.QueueConfiguration
import org.springframework.http.HttpStatus

class JesqueManagerJobController extends AbstractJesqueManagerController {

    def index() {
        [jobs: jesqueManagerService.doneJobList]
    }

    def failed() {
        sanitizeParams()
        [
                list : jesqueFailureService.getFailures(params.getLong("offset"), params.getLong("max")),
                total: jesqueFailureService.count
        ]
    }

    def manual() {
        [jobs: QueueConfiguration.jobTypes.keySet().sort()]
    }

    def requeue(long id) {
        jesqueFailureService.requeue(id.toLong())
        redirect(action: 'failed')
    }

    def remove(long id) {
        jesqueFailureService.remove(id.toLong())

        redirect(action: 'failed')
    }

    def clear() {
        jesqueFailureService.clear()

        redirect(action: 'failed')
    }

    def triggers() {
        [scheduledJobs: jesqueScheduledService.all.sort { it.trigger.nextFireTime.millis }]
    }

    def retryAll() {
        jesqueFailureService.count.times {
            jesqueFailureService.requeue(it)
        }

        redirect(action: 'failed')
    }

    def details() {
        sanitizeParams()
        params.sort = params.sort ?: 'start'
        params.order = params.order ?: 'desc'
        def list = jesqueManagerService.getJobListByName(params.id, params.getInt("max"), params.getInt("offset"), params.sort, params.order)
        [list: list]
    }

    def apiGet(long id) {
        def tempList = jesqueFailureService.getFailures(id, 1)
        def failure = [:]
        if (tempList) {
            failure = tempList.first()
        } else {
            response.status = HttpStatus.NOT_FOUND.value()
        }
        jsonRender([failure: failure])
    }

    def delayed() {
        [jobs: jesqueScheduledService.scheduledJobs]
    }

    def enqueue() {
        def clazz = QueueConfiguration.jobTypes.get(params.jobName)
        def list = params.getList('attrib[]').grep()
        if (list.size() == 1) {
            list = list.first()
            if (list.isNumber())
                list = list as long
        } else {
            def temp = []
            list.each { def value ->
                if (value.toString().isNumber()) {
                    temp.add(value as long)
                } else if (value instanceof String) {
                    temp.add(value.toBoolean())
                } else
                    temp.add(value)
            }
            list = temp
        }

        jesqueService.enqueue(QueueConfiguration.getQueueName(clazz), "$params.jobName", list)

        flash.success = true
        render(view: 'manual', model: [selectedJob: params.jobName, jobs: QueueConfiguration.jobTypes.keySet().sort()])
//        jsonRender([status: 'OK', jobName: params.jobName, parameters: params.attrs])
    }

    def apiFailedCount() {
        jsonRender([count: jesqueFailureService.count])
    }

    def apiDeleteTrigger() {
        jesqueScheduledService.delete(params.name)
        jsonRender([success: "OK"])
    }
}
