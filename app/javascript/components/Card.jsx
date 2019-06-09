import React from 'react';
// TODO: need to get this image url from the db and pass in as props
import office from '../../assets/images/office.jpg';

const Card = props => {
  console.log('here in card', props);
  return (
    <React.Fragment>
      <div className="row">
        {props.options.group.map((cohort, idx) => {
          return (
            <div key={idx}>
              <div className="col s12">
                <span className="white-text badge blue left">
                  {Object.keys(cohort)[0]}
                </span>
              </div>
              {Object.values(cohort)[0].map(group => {
                const belong_to_group =
                  group.name === props.options.current_user.group_name;

                return (
                  <div key={group.name}>
                    <div className="col s4 m4">
                      <div className="card">
                        <div className="card-image waves-effect waves-block waves-light">
                          <a href={'/groups/show/' + group.id}>
                            <img src={office} />
                          </a>
                        </div>
                        <div
                          className={
                            'card-content ' +
                            (belong_to_group
                              ? 'belongs_to_group'
                              : 'does_not_belong_to_group')
                          }
                        >
                          <span className="card-title activator">
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
