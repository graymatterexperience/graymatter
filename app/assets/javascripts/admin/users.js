function toggle_cohort_div(id) {
  var divelement = document.getElementById(id);
  var dividerLine = document.getElementById('divider-line')
  if (divelement.style.display == 'none') {
    divelement.style.display = 'table';
    dividerLine.style.display = 'block'
  } else {
    divelement.style.display = 'none';
    dividerLine.style.display = 'none'
  }

}
