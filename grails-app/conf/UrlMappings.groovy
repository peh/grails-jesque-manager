class UrlMappings {

    static mappings = {
        "/"(controller: 'jesqueManager', action: 'index')
        "/jobs"(controller: 'jesqueManagerJob', action: 'index')

        "/jesqueManager/api/queues"(controller: 'jesqueManagerQueue', action: 'apiNames')
        "/jesqueManager/api/workers"(controller: 'jesqueManagerWorker', action: 'apiWorkers')

        "/jesqueManager/api/failedCount"(controller: 'jesqueManagerJob', action: 'apiFailedCount')
        "/jesqueManager/api/failed"(controller: 'jesqueManagerJob', action: 'apiFailed')

        "500"(view: '/error')
    }
}
