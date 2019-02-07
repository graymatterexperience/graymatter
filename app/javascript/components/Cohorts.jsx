import ReactDOM from 'react-dom';
import React from 'react';
import PropTypes from 'prop-types';
import Input from './Input';
import Select from './Select';
import SelectStudent from './SelectStudent';
import Button from './Button';

const _ = require('lodash');

class Cohorts extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      cohorts: this.props.cohorts,
      cohortSelected: false,
      students: [],
      newGroup: {
        name: '',
        cohort: '',
        students: []
      }
    };

    // this.state = {
    //   group: '',
    //   cohorts: [],
    //   students: [],
    //   value: '',
    //   svalue: '',
    //   student: ''
    // };
    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleInput = this.handleInput.bind(this);
    // this.handleGroupName = this.handleGroupName.bind(this);
  }

  getStudents(cohort) {
    const url = `/admin/users.json?cohortName=${cohort}`;
    let fetchData = {
      method: 'GET',
      headers: new Headers()
    };
    fetch(url, fetchData)
      .then(response => {
        return response.json();
      })
      .then(data => {
        this.setState(
          prevState => ({
            students: data
          }),
          () => console.log(this.state)
        );
      })
      .catch(error => {
        console.log('student ERROR', error);
      });
  }

  handleInput(event) {
    let value = event.target.value;
    let name = event.target.name;

    if (name === 'cohort') {
      this.getStudents(value);
      this.setState(prevState => ({ cohortSelected: true }));
    }

    if (name === 'student') {
      const studentIncluded = _.includes(this.state.newGroup.students, value);
      console.log('BOOL', studentIncluded);
      if (!studentIncluded) {
        this.state.newGroup.students.push(value);
      } else {
        this.state.newGroup.students.splice(
          this.state.newGroup.students.indexOf(value),
          1
        );
      }
    }

    this.setState(
      prevState => ({
        newGroup: {
          ...prevState.newGroup,
          [name]: value
        }
      }),
      () => console.log(this.state)
    );
  }

  // headers: {
  //   Accept: 'application/json',
  //   'Content-Type': 'application/json'
  // }
  handleFormSubmit(event) {
    const url = '/admin/groups';
    event.preventDefault();
    const groupData = {
      group: this.state.newGroup
    };

    fetch(url, {
      method: 'POST',
      body: JSON.stringify(groupData),
      headers: new Headers()
    }).then(response => {
      response.json().then(data => {
        // have to deal with the error
        window.location.href = 'http://localhost:3000/admin/groups';
        console.log('Successful' + data);
      });
    });
  }

  handleClearForm(event) {
    event.preventDefault();
    this.setState({
      cohorts: this.props.cohorts,
      cohortSelected: false,
      students: [],
      newGroup: {
        name: '',
        cohort: '',
        students: []
      }
    });
    // alert(this.state.group);
  }
  // refreshStudentList = () => {
  //   debugger;
  // };

  componentDidMount() {
    $('select').formSelect();
    // $(element).ready(function() {});
    // $(document).ready(function() {
    // });

    // const url = '/admin/cohorts.json';
    // fetch(url)
    //   .then(response => {
    //     return response.json();
    //   })
    //   .then(data => {
    //     this.setState({ cohorts: data });
    //   });
  }

  renderStudents() {
    if (this.state.cohortSelected) {
      return (
        <div>
          <SelectStudent
            title={'Student'}
            name={'student'}
            options={this.state.students}
            value={this.state.newGroup.students}
            placeholder={'Select Students'}
            handleChange={this.handleInput}
          />{' '}
          {/* Add studants to the group */}
        </div>
      );
    } else {
      return null;
    }
  }

  render() {
    // const cohorts = this.props.cohorts;
    // const students = this.state.students;
    // const studentOptionItems = [];

    // const optionItems = cohorts.map(cohort => (
    //   <option key={cohort.name}>{cohort.name}</option>
    // ));

    // const optionItemsStudent = students.map(cohort => (
    //   <option key={cohort.first_name}>{cohort.first_name}</option>
    // ));

    // if (students.length > 0) {
    //   const studentOptionItems = students.map(student => (
    //     <option key={student.id}>{student.first_name}</option>
    //   ));
    //   console.log('here', studentOptionItems);
    // }

    //if (studentOptionItems.length > 0) {
    //// debugger;
    //}

    // console.log('here before HTML students', optionItemsStudent);

    return (
      <React.Fragment>
        <div className="input-field col s12">
          <form className="container-fluid" onSubmit={this.handleFormSubmit}>
            <Input
              type={'text'}
              title={'Group Name'}
              name={'name'}
              value={this.state.newGroup.name}
              placeholder={'Enter group name'}
              onChange={this.handleInput}
            />{' '}
            {/* Name of the group */}
            <Select
              title={'Cohort'}
              name={'cohort'}
              options={this.state.cohorts}
              value={this.state.newGroup.cohort}
              placeholder={'Select Cohort'}
              handleChange={this.handleInput}
            />{' '}
            {/* Cohort Selection */}
            <div>{this.renderStudents()}</div>
            <div className="card-action">
              <div className="right-align">
                <Button
                  action={this.handleFormSubmit}
                  type={'primary'}
                  title={'Submit'}
                  style={buttonStyle}
                />{' '}
                {/*Submit */}
                <Button
                  action={this.handleClearForm}
                  type={'secondary'}
                  title={'Clear'}
                  style={buttonStyle}
                />{' '}
                {/* Clear the form */}
              </div>
            </div>
          </form>
        </div>
      </React.Fragment>
    );
  }
}

// Cohorts.propTypes = {
//   cohortName: PropTypes.string
// };

const buttonStyle = {
  margin: '10px 10px 10px 10px'
};

export default Cohorts;
