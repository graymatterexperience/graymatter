import ReactDOM from 'react-dom';
import React from 'react';
import PropTypes from 'prop-types';
import Input from './Input';
import Select from './Select';
import SelectStudent from './SelectStudent';
import Button from './Button';
import CheckBox from './CheckBox';

const _ = require('lodash');

class Cohorts extends React.Component {
  constructor(props) {
    super(props);

    if (this.props.action === 'edit') {
      const students = this.getStudentsByGroup(props.group.group.id);
      this.state = {
        cohorts: [this.props.group.cohort],
        cohortSelected: true,
        students: [],
        newSelectionArray: [],
        newGroup: {
          name: this.props.group.group.name,
          cohort: this.props.group.cohort.name,
          students: students
        }
      };
    } else {
      this.state = {
        cohorts: this.props.cohorts,
        cohortSelected: false,
        students: [],
        newSelectionArray: [],
        newGroup: {
          name: '',
          cohort: '',
          students: []
        }
      };
    }

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
    this.handleCheckBox = this.handleCheckBox.bind(this);

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

  getStudentsByGroup(group_id) {
    const url = `/admin/getStudentsByGroup/${group_id}`;
    let fetchData = {
      method: 'GET',
      headers: new Headers()
    };
    fetch(url, fetchData)
      .then(response => {
        return response.json();
      })
      .then(data => {
        console.log('IDS', data.data);
        this.setState(
          prevState => ({
            newGroup: {
              ...prevState.newGroup,
              students: data.data
            }
          }),
          () => console.log('check box', this.state.newGroup.students)
        );
      })
      .catch(error => {
        console.log('student ERROR', error);
      });
  }

  handleCheckBox(event) {
    const newSelection = event.target.value;
    // let newSelectionArray;

    this.setState(
      (newSelectionArray = this.state.newGroup.students.filter(
        s => s !== newSelection
      ))
    );
    if (this.state.newGroup.students.indexOf(newSelection) > -1) {
      newSelectionArray = this.state.newGroup.students.filter(
        s => s !== newSelection
      );
    } else {
      newSelectionArray = [...this.state.newGroup.students, newSelection];
    }

    this.setState(
      prevState => ({
        newGroup: {
          ...prevState.newGroup,
          students: newSelectionArray
        }
      }),
      () => console.log('check box', this.state.newGroup.students)
    );
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
    let options, url;
    if (this.props.action === 'edit') {
      options = {
        method: 'PATCH',
        body: JSON.stringify(this.state.newGroup),
        headers: new Headers()
      };
      url = `/admin/groups/${this.props.group.group.id}`;
    } else {
      url = '/admin/groups';
      event.preventDefault();
      const groupData = {
        group: this.state.newGroup
      };
      options = {
        method: 'POST',
        body: JSON.stringify(groupData),
        headers: new Headers()
      };
    }

    fetch(url, options).then(response => {
      response.json().then(data => {
        // TODO: have to deal with the error
        window.location.href = 'http://localhost:3000/admin/groups';
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
      console.log('STUDENTs', this.state.students);
      return (
        <div>
          <CheckBox
            title={'Student'}
            name={'student'}
            options={this.state.students}
            selectedOptions={this.state.newGroup.students}
            handleChange={this.handleCheckBox}
          />{' '}
          {/* Skill */}
          {/*
          <SelectStudent
            title={'Student'}
            name={'student'}
            options={this.state.students}
            value={this.state.newGroup.students}
            placeholder={'Select Students'}
            handleChange={this.handleInput}
          />{' '}
           Add studants to the group */}
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
