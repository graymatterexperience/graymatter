import React from 'react';

const CheckBox = props => {
  return (
    <div className="form-group">
      <label htmlFor={props.name} className="form-label">
        {props.title}
      </label>
      <div className="">
        {props.options.map(option => {
          console.log('there are PROPS', props);
          console.log('option', option);
          console.log('props selectedOptions', props.selectedOptions);
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
