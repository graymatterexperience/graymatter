import React from 'react';
// TODO: need to get this image url from the db and pass in as props
import office from '../../assets/images/office.jpg';

const Card = props => {
  console.log('here in card', props);
  return (
    <React.Fragment>
      <div className="row">
        {props.options.group.map((cohort, idx) => {
          //   notes there is where i left off trying to get the value from the key
          console.log('cohort', cohort);

          return (
            <div key={idx}>
              <div className="col s12">
                <span className="white-text badge blue left">
                  {Object.keys(cohort)[0]}
                </span>
              </div>
              {Object.values(cohort)[0].map(group => {
                return (
                  <div key={group.name}>
                    <div className="col s4 m4">
                      <div className="card">
                        <div className="card-image waves-effect waves-block waves-light">
                          <a href={'/groups/show/' + group.id}>
                            <img src={office} />
                          </a>
                        </div>
                        <div className="card-content">
                          <span className="card-title activator grey-text">
                            {group.name}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                );
              })}
            </div>
          );
        })}
      </div>
    </React.Fragment>
  );
};

export default Card;
