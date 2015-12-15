import React from "react"
const cx = require('classnames')

export default class SortableTableColumn extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      sort: 'ASC'
    }
  }

  render () {
    return (
      <th className={cx('sortable', this.props.current.sort, {sorted: this.props.current.field == this.props.field})}>
        <a href="javascript:void(0)" onClick={() => {
          let newSort = 'asc';
          if (this.state.sort === newSort) {
            newSort = 'desc';
          }
          this.props
            .sort(this.props.field, newSort);
            this
            .setState({sort: newSort})
        }}>{this.props.children}</a>
      </th>
    )
  }
}

SortableTableColumn.propTypes = {
  field: React.PropTypes.string,
  current: React.PropTypes.object.isRequired,
  sort: React.PropTypes.func.isRequired
};
