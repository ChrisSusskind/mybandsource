/**
 * Created by Peter on 7/20/17.
 */

$(document).on('turbolinks:load', function() {
   setTimeout(hideAlert,3000);
   setTimeout(hideNotice,3000);
});

function hideAlert(){
    $('#alert').fadeOut('slow');
}

function hideNotice(){
    $('#notice').fadeOut('slow');
}