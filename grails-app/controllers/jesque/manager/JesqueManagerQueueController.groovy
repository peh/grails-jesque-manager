package jesque.manager

class JesqueManagerQueueController extends AbstractJesqueManagerController {

    def index() {
        def list = jesqueQueuesService.queueInfos
        [list: list.sort { it1, it2 -> it1.name <=> it2.name }]
    }

    def details() {
        [queue: jesqueQueuesService.getQueueInfo(params.id, 0, 1000)]
    }

    def remove() {
        jesqueQueuesService.removeQueue(params.id)
        redirect(controller: 'jesqueManagerQueue', action: 'index')
    }

    def apiQueues() {
        jsonRender([queues: jesqueQueuesService.queueInfos].sort { it1, it2 -> it1.name <=> it2.name })
    }
}
