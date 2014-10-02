package jesque.manager

class JesqueManagerController extends AbstractJesqueManagerController {

    def index() {
        [
                queueList        : jesqueQueuesService.queueInfos,
                totalFailureCount: jesqueFailureService.count,
                working          : jesqueWorkersService.activeWorkers,
                totalWorkerCount : jesqueWorkersService.workerCount
        ]
    }
}
