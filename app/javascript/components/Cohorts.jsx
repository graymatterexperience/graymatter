import ReactDOM from 'react-dom';
import React from 'react';
import Input from './Input';
import Select from './Select';
import Button from './Button';
import CheckBox from './CheckBox';

const _ = require('lodash');
// import Group from '../utility/group'; can't get this to work

class Cohorts extends React.Component {
  constructor(props) {
    super(props);

    if (this.props.action === 'edit') {
      // TODO do not need 'this'
      console.log('here in the set state', this.props.group.selected_students);
      this.state = {
        cohorts: [this.props.group.cohort],
        cohortSelected: true,
        students: props.group.all_cohort_students,
        newSelectionArray: [],
        checked: true,
        newGroup: {
          name: this.props.group.group.name,
          cohort: this.props.group.cohort.name,
          students: _.map(this.props.group.selected_students, 'id')
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
    console.log('here in getStudents');
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
    console.log('HERE I AM', e.target.value);
    // const newSelection = e.target.value.toInteger();

    const newSelection = parseInt(e.target.value);
    // I need to collect id's
    // const newSelection = e.target.value;
    let newSelectionArray;

    // const newSelection = this.state.students.find(
    //   student => student.id.toString() === e.target.value
    // );

    console.log('this is the newSelction needs to be ID', newSelection);
    console.log('this.state.newGroup.students', this.state.newGroup.students);

    // const studentsHere = _.map(this.state.newGroup.students, 'id');
    // console.log('studentsHere array of ids', studentsHere);

    // if (this.state.newGroup.students.indexOf(newSelection) > -1) {
    // console.log('the compairson', studentsHere.indexOf(newSelection) > -1);
    // console.log('the compairson studentsHere', studentsHere);
    console.log('the compairson newSelection', newSelection);

    if (this.state.newGroup.students.indexOf(newSelection) > -1) {
      // newSelectionArray = this.state.newGroup.students.filter(
      console.log('fucker face inside');
      newSelectionArray = this.state.newGroup.students.filter(
        s => s !== newSelection
      );
    } else {
      // newSelectionArray = [...this.state.newGroup.students, newSelection];
      newSelectionArray = [...this.state.newGroup.students, newSelection];
    }
    // const shit = Group.getGroup(3);
    // console.log('SHIT', shit);

    console.log('after checkbox logic should be IDS', newSelectionArray);

    this.setState(prevState => ({
      newSelectionArray: newSelectionArray,
      newGroup: {
        ...prevState.newGroup,
        students: newSelectionArray
      }
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
    console.log('this is working', event);
    let options, url;
    if (this.props.action === 'edit') {
      console.log('handle submit edit button');
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
        console.log('data fucker', data);
        // TODO: have to deal with the error action
        window.location.href = 'http://localhost:3000/admin/groups';
        // TODO this is SO wrong...
        // window.location.href =
        //   'http://staging-graymatter.herokuapp.com/admin/groups';
      });
    });
    console.log('did I make it here');
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
    // TODO this is so wrong
    console.log('handle clear form');
    window.location.href = 'http://localhost:3000/admin/groups';
    // window.location.href =
    //   'http://staging-graymatter.herokuapp.com/admin/groups';
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

      // const groupsStudents = this.getStudentsByGroup(2);
      // console.log('GROUPSSTUDENTS', groupsStudents);

      // console.log('groups', Group.getGroup(3));

      const checkedStudents = this.state.newGroup.students;
      console.log('student', this.state);

      return (
        <React.Fragment>
          <CheckBox
            title={'Student'}
            name={'student'}
            options={students}
            selectedOptions={checkedStudents}
            handleChange={this.handleCheckBox}
          />
          {/* students to add to a group */}
        </React.Fragment>
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
