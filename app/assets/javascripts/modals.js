//$(function() {
  //console.log('modals.js at the beginning')
  //const modal_holder_selector = '#modal-holder';
  //const modal_selector = '.modal';
  ////$('.modal').modal({
      ////dismissible: true
  ////});
  //$(document).on('click', 'a[data-modal]', function() {
  ////$('.modal-trigger').leanModal();
    //const location = $(this).attr('href');
    //// Load modal dialog from server

    ////$('.modal').modal();
    //console.log('modal_holder_selector', modal_holder_selector)
    //console.log('modal_selector', modal_selector)
    //$.get(
      //location,
      //data => { $(modal_holder_selector).html(data).find(modal_selector).modal('open') }
    //);
    //return false;
  //});

  //$(document).on('ajax:success', 'form[data-modal]', function(event){
    //const url = event.delegateTarget.URL;
    //// This does not work the way the tut showed
    //// https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
    //// event.detail - detail is undefined
    ////const [data, _status, xhr] = event.detail;
    ////const url = xhr.getResponseHeader('Location');
    ////console.log('URL', url)
    //if (url) {
      //// Redirect to url
      //window.location = url;
    //} else {
      //// Remove old modal backdrop
      //$('.modal-backdrop').remove();
      //// Update modal content
      ////const modal = $(data).find('body').html();
      ////$(modal_holder_selector).html(modal).find(modal_selector).modal();
      //$(modal_holder_selector).html(modal).find(modal_selector).modal('close');
    //}

    //return false;
  //});
//});


//function openResetPasswordModal () {
  //console.log('onpenResetPasswordModal beginning')
  //const modal_holder_selector = '#modal-holder';
  //const modal_selector = '.modal';

    //const location = '/password_resets/new';
    //// Load modal dialog from server

    //$.get(
      //location,
      //data => { $(modal_holder_selector).html(data).find(modal_selector).modal('open') }
    //);
    //return false;
//}

//// TODO this code below can not go here. it opens a modal on every page
//// also, this is a conditional only when users logs on for the first time
////window.onload = openResetPasswordModal;



