import React from 'react';
import PropTypes from 'prop-types';

class Groups extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      cohorts: [],
      students: []
    };
  }

  componentDidMount() {
    const url = '/admin/cohorts.json';
    fetch(url)
      .then(response => {
        return response.json();
      })
      .then(data => {
        this.setState({ cohorts: data });
      });
  }

  render() {
    const cohorts = this.state.cohorts;
    console.log('fuckerFACE', cohorts);
    return (
      <React.Fragment>
        Cohort Name: {this.props.cohortName}
        {/* {this.state.cohorts} */}
        <div className="row">
          <div className="input-field col s12" />
        </div>
      </React.Fragment>
    );
  }
}

Groups.propTypes = {
  cohortName: PropTypes.string
};

export default Groups;
