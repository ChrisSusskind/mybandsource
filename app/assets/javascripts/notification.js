/**
 * Created by Peter on 6/8/17.
 */

function markNotificationsViewed(){
    $.ajax({
        method: 'POST',
        url: '/notifications/mark_viewed_user'
    });
}