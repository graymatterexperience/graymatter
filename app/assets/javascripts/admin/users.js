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

function displayStudentInformation(student) {
  $.ajax({url: '/admin/users/' + student + '.json', success: function(result) {
    var stringId = result.id.toString();
    var studentInformationTag = document.getElementById(stringId);
    if (studentInformationTag.style.display == 'none') {
      studentInformationTag.style.display = 'table';
    } else {
      studentInformationTag.style.display = 'none';
    }
    var td = `
            <td colspan='6'>
                <ul>
                    <li>Phone: ${ result.user_information.phone }</li>
                    <li>School: ${ result.user_information.school }</li>
                    <li>Grade: ${ result.user_information.grade }</li>
                </ul>
            </td>
  `
    document.getElementById(stringId).innerHTML = td
  }})
}

$(document).ready(function(){
  $('.collapsible').collapsible();
})
