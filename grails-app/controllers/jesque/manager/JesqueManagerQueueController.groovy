package jesque.manager

class JesqueManagerQueueController extends AbstractJesqueManagerController {


    def apiNames() {
        jsonRender([queues: jesqueQueuesService.queueInfos])
    }
}
