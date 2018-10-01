function toggle_cohort_div(id) {
  var divelement = document.getElementById(id);
  if (divelement.style.display == 'none') {
    divelement.style.display = 'table';
  } else {
    divelement.style.display = 'none';
  }

}
