import React from "react"
import JobService from '../../services/job-service.js'
import Paginate from './../common/paginate.jsx'
import {map} from 'lodash'
const ReactMiniRouter = require('react-mini-router')
const moment = require('moment');
const MAX = 20;

export default class FailedList extends React.Component {

  constructor (props) {
    super(props);
    this.jobService = new JobService();
    this.state = {
      failed: [],
      offset: 0,
      total: 0
    };
    this._update = this._update
      .bind(this);
    this._remove = this._remove
      .bind(this);
    this._retry = this._retry
      .bind(this);
    this._removeAll = this._removeAll
      .bind(this);
    this._update();
    this.intervalId = setInterval(this._update, 5000);
  }

  _remove (id) {
    this.jobService
      .failedRemove(id);
    this._update();
  }

  _removeAll () {
    this.jobService
      .failedRemoveAll();
    this._update();
  }

  _retry (id) {
    this.jobService
      .failedRetry(id);
    this._update();
  }

  _update (props) {
    props = props || this.props;
    let offset = (props.page - 1) * MAX;
    this.jobService
      .failedList({max: MAX, offset: offset}, (data) => {
        if (data.list.length === 0 && offset > 0) {
          ReactMiniRouter.navigate(`/jobs/failed/1`)
        }
        this.state.failed = data.list;
        this.state.total = data.total;
        this.state.offset = offset;
        this.setState(this.state);
      })
  }

  componentWillUnmount () {
    clearInterval(this.intervalId)
  }

  componentWillReceiveProps (nextProps) {
    this._update(nextProps)
  }

  getTabeRows (list) {
    let i = 0;
    return map(list, (item) => {
      return (
        <tr key={`${i++ }`}>
          <td>{moment(item.failedAt).fromNow()}</td>
          <td>{item.payload.className}</td>
          <td>{item.throwableString}</td>
          <td>
            <button className="btn btn-sm btn-warning" onClick={() => {
              this._retry(i - 1 + this.state.offset)
            }}>
              <i className="fa fa-repeat"></i>
            </button>&nbsp;
            <button className="btn btn-sm btn-danger" onClick={() => {
              this._remove(i - 1 + this.state.offset)
            }}>
              <i className="fa fa-trash"></i>
            </button>
          </td>
        </tr>
      )
    });
  }

  render () {
    return (
      <div className="row">
        <div className="col-md-12">
          <div className="row">
            <div className="col-md-2 col-md-offset-10">
              <button className="btn btn-danger" onClick={this._removeAll}>
                <i className="fa fa-trash"></i>
                Remove All</button>
            </div>
          </div>
          <div className="row">
            <div className="col-md-12">
              <table className="table table-sm">
                <tbody>
                  {this.getTabeRows(this.state.failed)}
                </tbody>
              </table>
              <Paginate page={this.props.page} total={this.state.total} max={MAX} route="/jobs/failed/"/>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
