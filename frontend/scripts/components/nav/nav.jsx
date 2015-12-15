import React from 'react'
import Link from './../common/link.jsx'
const cx = require('classnames')
import {map} from 'lodash'

const JOB_ROUTES = [
  {
    controller: 'failed',
    route: '/jobs/failed/1',
    text: 'Failed'
  },
  {
    controller: 'scheduled',
    route: '/jobs/scheduled',
    text: "Scheduled"
  },
  {
    controller: 'delayed',
    route: ''
  }
]

export default class Nav extends React.Component {
  render () {
    const jobLinks = map(JOB_ROUTES, (route)=>{
      return <NavDropdownLink key={`route-${route.route}`} route={route.route} controller={route.controller}>{route.text}</NavDropdownLink>
    });
    return (
      <nav className="navbar navbar-dark bg-inverse">
        <Link route="/" className="navbar-brand">JesqueManager</Link>

        <ul className="nav navbar-nav">
          <NavLink route='/' controller='overview' text="Overview"/>
          <NavDropdown name="Jobs" routes={JOB_ROUTES}>
            {jobLinks}
          </NavDropdown>
        </ul>
      </nav>
    );
  }
}

class NavDropdown extends React.Component {
  render () {
    return (
      <li className="nav-item dropdown">
        <a className="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">{this.props.name}</a>
        <div className="dropdown-menu">
          {this.props.children}
        </div>
      </li>
    )
  }
}

class NavDropdownLink extends React.Component {
  render () {
    const classes = cx(this.props.className, 'dropdown-item', {active: this.props.controller === window.controller})
    return(
      <Link route={this.props.route} className={classes}>{this.props.children}</Link>
    )

  }
}


class NavLink extends React.Component {
  render () {
    const classes = cx('nav-item', {active: this.props.controller === window.controller})
    return(
      <li className={classes}>
        <Link route={this.props.route} className='nav-link'>{this.props.text}</Link>
      </li>
    )

  }
}
