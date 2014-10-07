package jesque.manager

import grails.plugin.jesque.GrailsJobFactory
import grails.plugin.jesque.QueueConfiguration
import net.greghaines.jesque.worker.JobFactory

class JesqueManagerWorkerController extends AbstractJesqueManagerController {

    def index() {
    }

    def manual() {
        [queues: QueueConfiguration.queueNames.sort()]
    }

    def startWorker() {
        List queue = [params.queueName as String]
        JobFactory jobFactory = new GrailsJobFactory(grailsApplication)
        jesqueService.startWorker(queue, jobFactory)
        flash.success = true
        redirect(action: 'manual')
    }

    def apiHostMap() {
        jsonRender(hostmap: jesqueWorkersService.workerHostMap)
    }

    def apiRemove() {
        jesqueWorkersService.removeWorker(params.name)
        jsonRender([success: 'OK'])
    }

    def apiWorkers() {
        jsonRender([workers: jesqueWorkersService.allWorkers])
    }
}
