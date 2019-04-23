import React from 'react';

const Button = props => {
  console.log('in button js', props.style);
  return (
    <button
      style={props.style}
      className={
        props.type == 'primary' ? 'btn light-green accent-4' : 'btn red'
      }
      onClick={props.action}
    >
      {props.title}
    </button>
  );
};

export default Button;
