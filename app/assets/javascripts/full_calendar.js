$(function() {

  console.log('in the js file')
  // page is now ready, initialize the calendar...

  $('#calendar').fullCalendar({
    events: '/events.json'
    // put your options and allbacks here
  })

});
