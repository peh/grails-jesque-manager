package jesque.manager

class JesqueManagerQueueController extends AbstractJesqueManagerController {


    def apiQueues() {
        jsonRender([queues: jesqueQueuesService.queueInfos])
    }
}
