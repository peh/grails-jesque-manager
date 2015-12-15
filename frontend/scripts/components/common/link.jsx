import React from "react"
const ReactMiniRouter = require('react-mini-router')

export default class Link extends React.Component {

  render () {

    return (
      <a className={this.props.className} href="#" onClick={(e) => {
        e.preventDefault();
        ReactMiniRouter.navigate(this.props.route, this.props.skipRouting)
      }}>
        {this.props.children}
      </a>
    )
  }
}

Link.propTypes = {
  className: React.PropTypes.string,
  skipRouting: React.PropTypes.bool,
  route: React.PropTypes.string.isRequired
};
