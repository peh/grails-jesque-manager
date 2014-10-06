package jesque.manager

import org.springframework.http.HttpStatus

class JesqueManagerJobController extends AbstractJesqueManagerController {

    def index() {}

    def failed() {
        sanitizeParams()
        [
                list: jesqueFailureService.getFailures(params.getLong("offset"), params.getLong("max")),
                total: jesqueFailureService.count
        ]
    }

    def apiGet(long id){
        def tempList = jesqueFailureService.getFailures(id, 1)
        def failure = [:]
        if(tempList) {
            failure = tempList.first()
        } else {
            response.status = HttpStatus.NOT_FOUND.value()
        }
        jsonRender([failure: failure])
    }

    def apiFailedCount() {
        jsonRender([count: jesqueFailureService.count])
    }


    def requeue(long id) {
        jesqueFailureService.requeue(id.toLong())
        redirect(action: 'failed')
    }

    def remove(long id) {
        jesqueFailureService.remove(id.toLong())

        redirect(action: 'failed')
    }

    def clear() {
        jesqueFailureService.clear()

        redirect(action: 'failed')
    }

    def retryAll() {
        jesqueFailureService.count.times {
            jesqueFailureService.requeue(it)
        }

        redirect(action: 'failed')
    }
}
