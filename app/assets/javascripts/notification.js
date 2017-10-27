/**
 * Created by Peter on 6/8/17.
 */

function markNotificationsViewed(){
    $.ajax({
        method: 'POST',
        url: '/notifications/mark_viewed_user',
    });
}

function retrieveNotifications(){
    $.ajax({
        method: 'GET',
        url: '/notifications/retrieve_notifications',
        success: function(data) {
            if(data.length > 0){
              $("#notification_dropdown_button").css( "color", "black" );
              $("#notification_dropdown_button").css( "background-color", "white" );
              $("#unviewed_notification_number").html(data.length);
            }
            else
            {
              $("#notification_dropdown_button").css( "color", "white" );
              $("#notification_dropdown_button").css( "background-color", "black" );
              $("#unviewed_notification_number").html(data.length);
              console.log("no new notifications");
            }
        },
        error: function(data) {
          console.log(data);
        }
    });
}


setInterval(function() {
    if($("body").data('login') == "yes"){
      retrieveNotifications();//retrieveNotifications();
    }
}, 1000); // 60 * 1000 milsec 



