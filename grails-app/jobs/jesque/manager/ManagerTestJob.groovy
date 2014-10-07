package jesque.manager

import grails.plugin.jesque.QueueConfiguration


class ManagerTestJob {

    static triggers = {
        cron name: 'ManagerTestJob',
                jesqueJobName: ManagerTestJob.simpleName,
                jesqueQueue: QueueConfiguration.getQueueName(ManagerTestJob),
                cronExpression: "0 * * * * ?",
                args: [1]
    }

    def perform(long arg) {
        sleep(5000)
        1 / arg
    }
}
