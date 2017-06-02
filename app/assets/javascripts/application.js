// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require 'starrating.js'
//= require 'review.js'
//= require 'jquery.timeago.js'
//= require 'jquery.debounce.js'
//= require react
//= require cloudinary
//= require cloudinary/processing
//= require react_ujs
//= require components

$(function() {
  if($.fn.cloudinary_fileupload !== undefined) {
    $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
  }

  console.log("Running FB init script");
  window.fbAsyncInit = function() {
      FB.init({
          appId      : '444853392519445',
          xfbml      : false
      });
      console.log("FB Initialized");
  };
  (function(d, s, id){
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) {return;}
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js";
      fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));
});

function markNotificationsViewed(){
    $('#notification_dropdown_button').prop('onclick', null);
    $.ajax({
       method: 'POST',
       url: '/notifications/mark_viewed_user'
    });
}

function signupToLoginModal(){
    $('#signup_modal').modal('hide');
}

function loginToSignupModal(){
    $('#login_modal').modal('hide');
}

function shareFacebook(url) {
    FB.ui({
        method: 'share',
        href: url
    }, function (response) {
    });

    console.log("Inside shareFacebook");
}

