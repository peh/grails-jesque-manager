class UrlMappings {

    static mappings = {
        "/"(controller: 'jesqueManager', action: 'index')
        "/jobs"(controller: 'jesqueManagerJob', action: 'index')
        "/jobs/failed"(controller: 'jesqueManagerJob', action: 'failed')

        "/jobs/requeue/$id"(controller: 'jesqueManagerJob', action: 'requeue')
        "/jobs/remove/$id"(controller: 'jesqueManagerJob', action: 'remove')
        "/jobs/clear"(controller: 'jesqueManagerJob', action: 'clear')
        "/jobs/retryAll"(controller: 'jesqueManagerJob', action: 'retryAll')

        "/jesqueManager/api/queues"(controller: 'jesqueManagerQueue', action: 'apiNames')
        "/jesqueManager/api/workers"(controller: 'jesqueManagerWorker', action: 'apiWorkers')

        "/jesqueManager/api/job/$id"(controller: 'jesqueManagerJob', action: 'apiGet')
        "/jesqueManager/api/failedCount"(controller: 'jesqueManagerJob', action: 'apiFailedCount')
        "/jesqueManager/api/failed"(controller: 'jesqueManagerJob', action: 'apiFailed')

        "500"(view: '/error')
    }
}
