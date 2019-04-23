import React from 'react';

const CheckBox = props => {
  return (
    <div className="form-group">
      <label htmlFor={props.name} className="form-label">
        {props.title}
      </label>
      <div className="">
        {props.options.map(option => {
          // NOTES: this here seems to be working do not touch
          // console.log('props.selectedOptions', props.selectedOptions);
          console.log('there are PROPS', props);
          console.log('option', option);
          console.log('props selectedOptions', props.selectedOptions);
          // groupNames = Group.getGroup(3);
          // TODO not working but I know I hit the API
          // console.log('group', groupNames);
          // const selectedStudentIds = props.selectedOptions.map(obj => {
          //   return obj.id;
          // });

          // // does not work
          // console.log('selected students', selectedStudentIds);
          // NOTES: id's need to be strings bc the componat retruns a string id
          console.log('PROPS', props);

          const stringId = option.id.toString();
          return (
            <label key={option.id} id={option.id}>
              <input
                id={props.id}
                name={props.name}
                onChange={props.handleChange}
                value={option.id}
                checked={props.selectedOptions.indexOf(option.id) > -1}
                type="checkbox"
              />
              <span>
                <b>
                  {option.first_name} {option.last_name}{' '}
                </b>
                |{' '}
                {option.user_information.group_name || (
                  <span className="blue_text">Not assigned a group</span>
                )}
              </span>
              <br />
            </label>
          );
        })}
      </div>
    </div>
  );
};

export default CheckBox;
