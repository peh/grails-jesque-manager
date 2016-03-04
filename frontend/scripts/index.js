import React from 'react'
import ReactDom from 'react-dom'
import Nav from './components/nav/nav.jsx'
import Overview from './components/overview/overview.jsx'
import FailedList from './components/jobs/failed-list.jsx'

const RouterMixin = require('react-mini-router').RouterMixin;
window.jQuery = require('jquery');
window.$ = window.jQuery;
window.Tether = require('Tether')
require('bootstrap')

var App = React.createClass({

  mixins: [RouterMixin],

  routes: {
    '/': 'overview',
    '/jobs/failed/:page': 'failedList',
    '/jobs': 'jobsList',
    '/message/:text': 'message'
  },

  jobsList: function() {
    window.controller = 'jobs'
    return (
      <div className="row">
        <div className="col-md-12">
          Job List
        </div>
      </div>
    )
  },

  failedList: function(page) {
    if (!page) {
      page = 1
    } else if (typeof page === 'string') {
      page = parseInt(page)
    }
    return <FailedList page={page} />
  },

  overview: function() {
    window.controller = 'overview'
    return <Overview/>
  },

  render: function() {
    return (
      <div className="app-container">
        <Nav/>
        <div className="container-fluid app-content">
          {this.renderCurrentRoute()}
        </div>
      </div>
    )

  },

  message: function(text) {
    return <div>{text}</div>;
  },

  notFound: function(path) {
    return <div class="not-found">Page Not Found:
      {path}</div>;
  }

});

ReactDom.render(
  <App history={false}/>, document.getElementById('jesque-container'));
