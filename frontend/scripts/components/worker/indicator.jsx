import React from 'react'
const cx = require('classnames')

export default class Indicator extends React.Component {
  render () {
    let classes = cx('fa', {
      'fa-circle-o-notch': this.props.state === 'IDLE' || this.props.state === 'WORKING',
      'fa-spin': this.props.state === 'WORKING',
      'fa-pause-circle-o': this.props.state === 'PAUSED'
    });
    return <i className={classes}></i>
  }
}
