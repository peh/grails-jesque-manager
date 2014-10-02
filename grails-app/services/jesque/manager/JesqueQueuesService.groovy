package jesque.manager

import grails.transaction.Transactional
import net.greghaines.jesque.meta.dao.QueueInfoDAO

@Transactional
class JesqueQueuesService {

    QueueInfoDAO queueInfoDao

    def getQueueInfos(){
        queueInfoDao.queueInfos
    }

    def getQueueInfo(def name, offset, max){
        queueInfoDao.getQueueInfo(name, offset, max)
    }

    def getQueueNames(){
        queueInfoDao.queueNames
    }

    def getPendingCount(){
        queueInfoDao.pendingCount
    }

    def getProcessedCount(){
        queueInfoDao.processedCount
    }

    def removeQueue(String name) {
        queueInfoDao.removeQueue(name)
    }

}
