import React from 'react';

const Select = props => {
  return (
    <div className="form-group">
      <label htmlFor={props.name}> {props.title} </label>
      <select
        id={props.name}
        name={props.name}
        value={props.value}
        onChange={props.handleChange}
        className="form-control"
      >
        <option value="" disabled>
          {props.placeholder}
        </option>
        {props.options.map(option => {
          return (
            <option key={option.name} value={option.name} label={option.name}>
              {option.name}
            </option>
          );
        })}
      </select>
    </div>
  );
};

export default Select;
