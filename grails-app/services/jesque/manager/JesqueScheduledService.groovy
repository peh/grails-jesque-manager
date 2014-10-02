package jesque.manager

import grails.plugin.jesque.ScheduledJobDaoService
import grails.transaction.Transactional

@Transactional
class JesqueScheduledService {

    ScheduledJobDaoService scheduledJobDaoService

    def getAll() {
        scheduledJobDaoService.getAll()
    }
}
