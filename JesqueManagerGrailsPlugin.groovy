class JesqueManagerGrailsPlugin {
    def version = "1.0-SNAPSHOT"
    def grailsVersion = "2.4 > *"
    def dependsOn = [jesque: '0.9-SNAPSHOT > *']
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

    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/jesque-manager"

    // Extra (optional) plugin metadata

    // License: one of 'APACHE', 'GPL2', 'GPL3'
//    def license = "APACHE"

    // Details of company behind the plugin (if there is one)
    def organization = [ name: "uberall", url: "http://www.uberall.com/" ]

    // Any additional developers beyond the author specified above.
//    def developers = [ [ name: "Joe Bloggs", email: "joe@bloggs.net" ]]

    // Location of the plugin's issue tracker.
    def issueManagement = [ system: "GitHub", url: "https://github.com/peh/grails-jesque-manager/issues" ]

    // Online location of the plugin's browseable source code.
    def scm = [ url: "https://github.com/peh/grails-jesque-manager" ]

    def doWithWebDescriptor = { xml ->
        // TODO Implement additions to web.xml (optional), this event occurs before
    }

    def doWithSpring = {
        // TODO Implement runtime spring config (optional)
    }

    def doWithDynamicMethods = { ctx ->
        // TODO Implement registering dynamic methods to classes (optional)
    }

    def doWithApplicationContext = { ctx ->
        // TODO Implement post initialization spring config (optional)
    }

    def onChange = { event ->
        // TODO Implement code that is executed when any artefact that this plugin is
        // watching is modified and reloaded. The event contains: event.source,
        // event.application, event.manager, event.ctx, and event.plugin.
    }

    def onConfigChange = { event ->
        // TODO Implement code that is executed when the project configuration changes.
        // The event is the same as for 'onChange'.
    }

    def onShutdown = { event ->
        // TODO Implement code that is executed when the application shuts down (optional)
    }
}
