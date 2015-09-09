class JesqueManagerGrailsPlugin {
    def version = "1.0.5-SNAPSHOT"
    def grailsVersion = "2.4 > *"
    def dependsOn = [jesque: '0.9.2-SNAPSHOT > *']
    def pluginExcludes = [
            "grails-app/views/error.gsp",
            "src/groovy/grails/plugin/jesqueweb/test/**",
            "test/**",
    ]

    // TODO Fill in these fields
    def title = "Jesque Manager Plugin" // Headline display name of the plugin
    def author = "Philipp Eschenbach"
    def authorEmail = "philipp@uberall.com"
    def description = '''\
Web Frontend to manage Jesque queues, workers and jobs.
'''

    def documentation = "http://grails.org/plugin/jesque-manager"

    def license = "APACHE"

    def organization = [ name: "uberall", url: "http://www.uberall.com/" ]

    def issueManagement = [ system: "GitHub", url: "https://github.com/peh/grails-jesque-manager/issues" ]

    def scm = [ url: "https://github.com/peh/grails-jesque-manager" ]

    def doWithWebDescriptor = { xml ->
    }

    def doWithSpring = {
    }

    def doWithDynamicMethods = { ctx ->
    }

    def doWithApplicationContext = { ctx ->
    }

    def onChange = { event ->
    }

    def onConfigChange = { event ->
    }

    def onShutdown = { event ->
    }
}
