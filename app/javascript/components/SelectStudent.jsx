import React from 'react';

const SelectStudent = props => {
  console.log('PROPS', props);
  return (
    <div className="form-group">
      <label htmlFor={props.name}> {props.title} </label>
      <select
        multiple
        id={props.id}
        name={props.name}
        value={props.value}
        onChange={props.handleChange}
        className="student-select-box form-control browser-default"
      >
        <option value="" disabled>
          {props.placeholder}
        </option>
        {props.options.map(option => {
          console.log('OPTION', option);
          return (
            <option key={option.id} value={option.id} label={option.first_name}>
              {option.first_name}
            </option>
          );
        })}
      </select>
    </div>
  );
};

export default SelectStudent;
