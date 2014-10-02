package jesque.manager

class JesqueManagerWorkerController extends AbstractJesqueManagerController {

    def index() {}

    def apiWorkers() {
        jsonRender([workers: jesqueWorkersService.activeWorkers])
    }
}
