$(function() {

  console.log('in the js file')
  // page is now ready, initialize the calendar...

  $('#calendar').fullCalendar({
    events: '/events.json',
    // front the blog
    eventRender: function (event, element) {
      element.attr('href', 'javascript:void(0);');
      element.click(function() {
        $("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
        $("#endTime").html(moment(event.end).format('MMM Do h:mm A'));
        $("#eventInfo").html(event.description);
        $("#eventLink").attr('href', event.url);
        $("#eventContent").dialog({ modal: true, title: event.title, width:350});
      });
    }
    // put your options and allbacks here
  })

});
