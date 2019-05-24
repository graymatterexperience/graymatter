import React from 'react';
import PropTypes from 'prop-types';
import Card from './Card';

class Groups extends React.Component {
  constructor(props) {
    super(props);
    console.log('props', this.props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(event) {
    console.log('this is working', event);
  }

  render() {
    return (
      <React.Fragment>
        <Card options={this.props} />
      </React.Fragment>
    );
  }
}

Groups.propTypes = {
  cohortName: PropTypes.string,
  groupName: PropTypes.string
};
export default Groups;
