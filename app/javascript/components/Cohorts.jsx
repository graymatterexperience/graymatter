import ReactDOM from 'react-dom';
import React from 'react';
import Input from './Input';
import Select from './Select';
import Button from './Button';
import CheckBox from './CheckBox';

const _ = require('lodash');

class Cohorts extends React.Component {
  constructor(props) {
    super(props);

    if (this.props.action === 'edit') {
      this.state = {
        cohorts: [this.props.group.cohort],
        cohortSelected: true,
        students: props.group.all_cohort_students,
        newSelectionArray: [],
        checked: true,
        newGroup: {
          name: this.props.group.group.name,
          cohort: this.props.group.cohort.name,
          students: props.group.selected_students
        }
      };
    } else {
      this.state = {
        cohorts: this.props.cohorts,
        cohortSelected: false,
        studentsSelected: [],
        students: [],
        newGroup: {
          name: '',
          cohort: '',
          students: []
        }
      };
    }

    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.handleClearForm = this.handleClearForm.bind(this);
    this.handleInput = this.handleInput.bind(this);
    this.handleCheckBox = this.handleCheckBox.bind(this);
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
        console.log('GET student ERROR', error);
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
        const studentId = data.data.map(e => e.id.toString());
        this.setState(
          prevState => ({
            newGroup: {
              ...prevState.newGroup,
              students: studentId
            }
          }),
          () => console.log('check box', this.state.newGroup.students)
        );
      })
      .catch(error => {
        console.log('GET student by group ERROR', error);
      });
  }

  handleCheckBox(e) {
    const newSelection = e.target.value;
    let newSelectionArray;

    if (this.state.newGroup.students.indexOf(newSelection) > -1) {
      newSelectionArray = this.state.newGroup.students.filter(
        s => s !== newSelection
      );
    } else {
      newSelectionArray = [...this.state.newGroup.students, newSelection];
    }

    this.setState(prevState => ({
      newSelectionArray: newSelectionArray,
      newGroup: { ...prevState.newGroup, students: newSelectionArray }
    }));
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
    this.state = {
      cohorts: this.props.cohorts,
      cohortSelected: false,
      studentsSelected: [],
      students: [],
      newGroup: {
        name: '',
        cohort: '',
        students: []
      }
    };
    window.location.href = 'http://localhost:3000/admin/groups';
  }

  componentDidMount() {
    $('select').formSelect();
  }

  renderStudents() {
    if (this.state.cohortSelected) {
      let students;
      if (this.props.action === 'new') {
        students = _.filter(this.state.students, ['group_id', null]);
      } else {
        students = this.state.students;
      }

      const checkedStudents = this.state.newGroup.students;
      return (
        <div>
          <CheckBox
            title={'Student'}
            name={'student'}
            options={students}
            selectedOptions={this.state.newGroup.students}
            handleChange={this.handleCheckBox}
          />{' '}
          {/* students to add to a group */}
        </div>
      );
    } else {
      return null;
    }
  }

  render() {
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
                  title={'Cancel'}
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

const buttonStyle = {
  margin: '10px 10px 10px 10px'
};

export default Cohorts;
