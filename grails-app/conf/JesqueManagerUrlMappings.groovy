class JesqueManagerUrlMappings {

    static mappings = {
        "/jesqueManager"(controller: 'jesqueManager', action: 'index')

        "/jesqueManager/jobs"(controller: 'jesqueManagerJob', action: 'index')
        "/jesqueManager/jobs/failed"(controller: 'jesqueManagerJob', action: 'failed')
        "/jesqueManager/jobs/requeue/$id"(controller: 'jesqueManagerJob', action: 'apiRetry')
        "/jesqueManager/jobs/remove/$id"(controller: 'jesqueManagerJob', action: 'apiRemove')
        "/jesqueManager/jobs/removeAll"(controller: 'jesqueManagerJob', action: 'apiRemoveAll')
        "/jesqueManager/jobs/retryAll"(controller: 'jesqueManagerJob', action: 'apiRetryAll')
        "/jesqueManager/jobs/manual"(controller: 'jesqueManagerJob', action: 'manual')
        "/jesqueManager/jobs/enqueue"(controller: 'jesqueManagerJob', action: 'enqueue')
        "/jesqueManager/jobs/details/$id"(controller: 'jesqueManagerJob', action: 'details')
        "/jesqueManager/jobs/trigger"(controller: 'jesqueManagerJob', action: 'triggers')
        "/jesqueManager/jobs/delayed"(controller: 'jesqueManagerJob', action: 'delayed')

        "/jesqueManager/queues"(controller: 'jesqueManagerQueue', action: 'index')
        "/jesqueManager/queues/details/$id"(controller: 'jesqueManagerQueue', action: 'details')
        "/jesqueManager/queues/remove"(controller: 'jesqueManagerQueue', action: 'remove')

        "/jesqueManager/workers"(controller: 'jesqueManagerWorker', action: 'index')
        "/jesqueManager/workers/manual"(controller: 'jesqueManagerWorker', action: 'manual')
        "/jesqueManager/workers/start"(controller: 'jesqueManagerWorker', action: 'startWorker')


        "/jesqueManager/api/overview"(controller: 'jesqueManager', action: 'apiOverview')
        "/jesqueManager/api/queues"(controller: 'jesqueManagerQueue', action: 'apiQueues')
        "/jesqueManager/api/workers"(controller: 'jesqueManagerWorker', action: 'apiWorkers')
        "/jesqueManager/api/job/$id"(controller: 'jesqueManagerJob', action: 'apiGet')
        "/jesqueManager/api/job/$id/retry"(controller: 'jesqueManagerJob', action: 'apiRetry')
        "/jesqueManager/api/failedCount"(controller: 'jesqueManagerJob', action: 'apiFailedCount')
        "/jesqueManager/api/failed"(controller: 'jesqueManagerJob', action: 'apiFailed')
        "/jesqueManager/api/jobs"(controller: 'jesqueManagerJob', action: 'apiList')
        "/jesqueManager/api/hostMap"(controller: 'jesqueManagerWorker', action: 'apiHostMap')
        "/jesqueManager/api/removeWorker"(controller: 'jesqueManagerWorker', action: 'apiRemove')
        "/jesqueManager/api/deleteTrigger"(controller: 'jesqueManagerJob', action: 'apiDeleteTrigger')

        "500"(view: '/error')
    }
}
