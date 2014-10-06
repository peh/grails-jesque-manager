grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"

grails.project.fork = [
        test   : false,
        run    : false,
        war    : false,
        console: false
]

grails.project.dependency.resolver = "ivy" // or ivy
grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    repositories {
        grailsCentral()
        mavenLocal()
        mavenCentral()
        // uncomment the below to enable remote dependency resolution
        // from public Maven repositories
        mavenRepo "http://repository.codehaus.org"
        mavenRepo "http://download.java.net/maven/2/"
        mavenRepo "http://repository.jboss.com/maven2/"
        mavenRepo "https://oss.sonatype.org/content/repositories/snapshots/"
        mavenRepo "http://repo.grails.org/grails/libs-releases/"
    }
    dependencies {
        compile "org.springframework:spring-expression:$springVersion"
        compile "org.springframework:spring-aop:$springVersion"
    }

    plugins {
        build(":tomcat:7.0.54"){
            export = false
        }

        build(":release:3.0.1", ":rest-client-builder:1.0.3") {
            export = false
        }

        compile(':redis:1.5.5') {
            export = false
        }
        compile(':jesque:0.9.2-SNAPSHOT') {
            changing = true
            export = false
        }
    }
}
