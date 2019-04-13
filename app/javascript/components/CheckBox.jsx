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
          console.log('option', option);
          console.log('props selectedOptions', props.selectedOptions);
          // const selectedStudentIds = props.selectedOptions.map(obj => {
          //   return obj.id;
          // });

          // // does not work
          // console.log('selected students', selectedStudentIds);
          // NOTES: id's need to be strings bc the componat retruns a string id

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
                {option.first_name} {option.last_name}
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
