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

    def apiOverview(){
        jsonRender([
                queues: jesqueQueuesService.queueInfos.sort { it1, it2 -> it1.name <=> it2.name },
                workers: jesqueWorkersService.allWorkers,
                failed: jesqueFailureService.count
        ])
    }
}
