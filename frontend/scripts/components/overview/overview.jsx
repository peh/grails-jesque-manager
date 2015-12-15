import React from 'react'
import ApplicationService from './../../services/application-service.js'
import Indicator from './../worker/indicator.jsx'
import SortableTableColumn from './../common/sortable-table-column.jsx'
import {map, filter, sortByOrder} from 'lodash'
const ReactMiniRouter = require('react-mini-router')
const moment = require('moment')
const cx = require('classnames')
var Tooltip = require('rc-tooltip');

export default class Overview extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      queues: [],
      workers: [],
      failed: 0,
      workerFilter: null,
      queueFilter: null,
      workerSort: null,
      queueSort: null
    };
    this.service = new ApplicationService();
    this.update = this.update
      .bind(this);
    this.componentWillUnmount = this.componentWillUnmount
      .bind(this);
    this._setQueueFilter = this._setQueueFilter
      .bind(this);
    this._setWorkerFilter = this._setWorkerFilter
      .bind(this);
    this._setWorkerSort = this._setWorkerSort
      .bind(this);
    this._setQueueSort = this._setQueueSort
      .bind(this);
    this.intervalId = setInterval(this.update, 2000);
    this.update();

  }

  update () {
    this.service
      .overview((data) => {
        this.state.queues = data.queues;
        this.state.workers = data.workers;
        this.state.failed = data.failed;
        this.setState(this.state)
      })
  }

  _setQueueFilter (e) {
    this.state.queueFilter = e.target.value;
    this.setState(this.state)
  }

  _setWorkerFilter (e) {
    this.state.workerFilter = e.target.value;
    this.setState(this.state)
  }

  _setQueueSort (field, sort) {
    this.state.queueSort = {
      field: field,
      sort: sort
    };
    this.setState(this.state);
  }

  _setWorkerSort(){}

  componentWillUnmount () {
    clearInterval(this.intervalId)
  }
  render () {

    let {queues, workers} = this.state;

    let queueSort = this.state.queueSort || {
      field: 'name',
      sort: 'asc'
    }
    if (this.state.queueFilter) {
      let query = this.state
        .queueFilter
        .toLowerCase();
      queues = filter(queues, (queue) => {
        return queue.name
          .toLowerCase()
          .indexOf(query) > -1
      })
    }

    queues = sortByOrder(queues, queueSort.field, queueSort.sort)


    if (this.state.workerFilter) {
      let query = this.state
        .workerFilter
        .toLowerCase();
      workers = filter(workers, (worker) => {
        return worker.status && worker.status
          .payload
          .className
          .toLowerCase()
          .indexOf(query) > -1
      })
    }
    let queueRows = map(queues, (queue) => {
      return (
        <tr key={queue.name}>
          <td>{queue.name}</td>
          <td>{queue.size}</td>
        </tr>
      )
    })

    let failed = this.state.failed;
    let failedClasses = cx('clickable', {
      'table-success': failed === 0,
      'table-warning': failed > 0 && failed <= 10,
      'table-danger': failed > 10
    });
    queueRows.push(
      <tr key="failed" className={failedClasses} onClick={()=>{ReactMiniRouter.navigate('/jobs/failed/1')}}>
        <td>Failed</td>
        <td>{this.state.failed}</td>
      </tr>
    );

    let workerRows = map(workers, (worker) => {
      // Hostname	PID	State	Job	since	Queues
      if (worker.status !== null) {
        let jobName = worker.status.payload.className
        let runAt = moment(worker.status.runAt).fromNow()
        return (
          <tr key={`${worker.host}-${worker.pid}`}>
            <td><Indicator state={worker.state.name}/></td>
            <td>{worker.host} <small>({worker.pid})</small> </td>
            <td>
              <Tooltip placement="left" trigger={['click']} overlay={<span>foo</span>}><span>{jobName}</span></Tooltip>
            </td>
            <td>{runAt}</td>
          </tr>
        )
      }
    });

    return (
      <div className="row">
        <div className="col-md-6 col-sm-12">
          <input type="text" placeholder="Search" className="form-control" onChange={this._setQueueFilter} value={this.state.queueFilter}/>
          <table className="table table-hover table-sm">
            <thead>
              <tr>
                <SortableTableColumn sort={this._setQueueSort} field="name" current={queueSort}>Name</SortableTableColumn>
                <SortableTableColumn sort={this._setQueueSort} field="size" current={queueSort}>Size</SortableTableColumn>
              </tr>
            </thead>
            <tbody>
              {queueRows}
            </tbody>
          </table>
        </div>
        <div className="col-md-6 col-sm-12">
          <input type="text" placeholder="Search" className="form-control" onChange={this._setWorkerFilter} value={this.state.workerFilter}/>
          <table className="table table-hover table-sm">
            <thead>
              <tr>
                <th></th>
                <th>Hostname</th>
                <th>Job</th>
                <th>Started</th>
              </tr>
            </thead>
            <tbody>
              {workerRows}
            </tbody>
          </table>
        </div>
      </div>
    )
  }
}

class OverviewCol extends React.Component {
  render() {

  }
}
