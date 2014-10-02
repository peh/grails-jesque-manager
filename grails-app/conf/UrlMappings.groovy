class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'jesqueManager', action: 'index')
        "500"(view:'/error')
	}
}
