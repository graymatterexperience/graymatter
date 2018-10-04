function clear_filter() {
  document.getElementById('clear-filter-chip').style.display = 'none';
  location.reload();
}

function toggle_cohort_div(id) {
  document.getElementById('clear-filter-chip').style.display = 'inline-block';
  var divelement = document.getElementById(id);
  if (divelement.style.display == 'none') {
    divelement.style.display = 'table';
  } else {
    divelement.style.display = 'none';
  }

}

function displayStudentInformation(user_id) {
  $.ajax({url: '/admin/users/' + user_id + '.json', success: function(result) {
    var stringId = result.id.toString();
    var userInformationTag = document.getElementById(stringId);
    if (userInformationTag.style.display == 'none') {
      userInformationTag.style.display = 'table';
    } else {
      userInformationTag.style.display = 'none';
    }

    if (result.role === 'student') {
      var td = `
            <td colspan='6'>
                <ul>
                    <li>Phone: ${ result.user_information.phone || 'N/A' }</li>
                    <li>School: ${ result.user_information.school || 'N/A' }</li>
                    <li>Grade: ${ result.user_information.grade || 'N/A' }</li>
                    <li>Role: ${ result.role || 'N/A' }</li>
                </ul>
            </td>
           `
    } else if (result.role === 'mentor') {
      var td = `
            <td colspan='6'>
                <ul>
                    <li>Role: ${ result.role || 'N/A' }</li>
                    <li>Cohort: ALL</li>
                </ul>
            </td>
           `
    }

    document.getElementById(stringId).innerHTML = td
  }})
}

$(document).ready(function(){
  $('.collapsible').collapsible();
})
