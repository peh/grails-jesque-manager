import React from "react"
import Link from './link.jsx'
import {times, inRange} from 'lodash'
const cx = require('classnames')
// const ReactMiniRouter = require('react-mini-router')

export default class Paginate extends React.Component {

  getPages (pages, page, route) {
    let rows = [];
    times(pages, (pa) => {
      let p = pa + 1;
      let firstLastCurrent = p === 1 || p === pages || p === page;
      if (firstLastCurrent || (pages < 9) || inRange(p, page - 2, page + 3)) {
        rows.push(
          <li key={`page-button-${p}`} className={cx('page-item', {
            'active': page === p
          })}>
            <Link route={`${route}${p}`} className='page-link'>{p}</Link>
          </li>
        )
      } else if (page - 3 === p || page + 3 === p) {
        rows.push(
          <li key={`page-button-${p}`} className='page-item disabled'>
            <a className='page-link'>
              <span>...</span>
            </a>
          </li>
        )
      }

    });
    return rows;
  }

  getPrevButton (page, route) {
    let prev = 1;
    if (page > 1) {
      prev = page - 1;
    }

    return (
      <li className={cx('page-item', {
        disabled: page <= 1
      })}>
        <Link route={`${route}${prev}`} className='page-link'>
          <span aria-hidden="true">&laquo;</span>
        </Link>
      </li>
    )
  }

  getNextButton (pages, page, route) {
    let next = page + 1;
    if (next >= pages) {
      next = pages;
    }
    return (
      <li className={cx('page-item', {
        disabled: page >= pages
      })}>
        <Link route={`${route}${next}`} className='page-link'>
          <span aria-hidden="true">&raquo;</span>
        </Link>
      </li>
    )
  }

  render () {
    let pages = Math.ceil(this.props.total / this.props.max);

    return (
      <ul className="pagination">
        {this.getPrevButton(this.props.page, this.props.route)}
        {this.getPages(pages, this.props.page, this.props.route)}
        {this.getNextButton(pages, this.props.page, this.props.route)}
      </ul>
    )
  }
}

/**
<a className={this.props.className} href="#" onClick={(e) => {
  e.preventDefault();
  ReactMiniRouter.navigate(this.props.route, this.props.skipRouting)
}}>
  {this.props.children}
</a>
**/
Paginate.propTypes = {
  className: React.PropTypes.string,
  page: React.PropTypes.number.isRequired,
  total: React.PropTypes.number.isRequired,
  max: React.PropTypes.number.isRequired,
  route: React.PropTypes.string.isRequired
};
