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

$(document).ready(function(){
  $('.collapsible').collapsible();
})
