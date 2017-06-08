/**
 * Created by Peter on 6/8/17.
 */

function markNotificationsViewed(){
    $('#notification_dropdown_button').prop('onclick', null);
    $.ajax({
        method: 'POST',
        url: '/notifications/mark_viewed_user'
    });
}