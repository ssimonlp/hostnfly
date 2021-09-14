import React, { useState, useEffect } from 'react';
import classes from './Missions.module.css'

const Missions = () => {
  const axios = require('axios').default;
  const [missions, setMissions] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
        const result = await axios('api/v1/missions');
        setMissions(result.data)
    };
    fetchData();
  }, [axios])
  
  const onClickHandler = async () => {
    try {
      const result = await axios.post('api/v1/missions')
      setMissions(result.data)
    } catch(error) {
      console.log(error);
    }
  };
  let content = <button 
                  className={classes.button}
                  onClick={onClickHandler}
                >
                  Generate missions
                </button>;

if (missions.length) {
  content = <ul>
      {missions.map((mission, index) => (
        <li key={index}>
          <div>Listing id : {mission.listing_id}, Mission type : {mission.type}, Date : {mission.date}, Price : {mission.price}</div>

        </li>
      ))}
    </ul>
  }
  
  return (
    <section>
      {content}
    </section>
  )
};
export default Missions;