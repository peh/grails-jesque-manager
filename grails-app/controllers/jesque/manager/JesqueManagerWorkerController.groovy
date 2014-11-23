package jesque.manager

import grails.plugin.jesque.GrailsJobFactory
import grails.plugin.jesque.QueueConfiguration
import net.greghaines.jesque.meta.WorkerInfo
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
        def hostmap =  jesqueWorkersService.workerHostMap
        def sortedMap = [:]
        hostmap.each { String host, List<WorkerInfo> list ->
            def sortedList = list.sort{it1, it2 -> it1.pid <=> it2.pid}
            sortedMap << [(host): sortedList]
        }
        jsonRender(hostmap: sortedMap)
    }

    def apiRemove() {
        jesqueWorkersService.removeWorker(params.name)
        jsonRender([success: 'OK'])
    }

    def apiWorkers() {
        jsonRender([workers: jesqueWorkersService.allWorkers])
    }
}
