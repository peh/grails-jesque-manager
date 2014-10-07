package jesque.manager



import net.greghaines.jesque.meta.dao.QueueInfoDAO
import net.greghaines.jesque.meta.dao.FailureDAO
import grails.plugin.spock.IntegrationSpec

class ManagerTestJobSpec extends IntegrationSpec {

    def jesqueService
    QueueInfoDAO queueInfoDao
    FailureDAO failureDao

    def "test ManagerTestJobSpec simple functionality"() {
        given:
        def queueName = "ManagerTestJobSpecQueue"

        when:
        // TODO: add when

        then:
        true
    }
}
