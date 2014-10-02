package jesque.manager

class JesqueManagerJobController extends AbstractJesqueManagerController{

    def index() { }


    def apiFailed(){

    }

    def apiFailedCount(){
        jsonRender([count: jesqueFailureService.count])
    }
}
