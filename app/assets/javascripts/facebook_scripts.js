/**
 * Created by Peter on 6/8/17.
 */

function shareFacebook(url) {
    if(FB){
        FB.ui({
            method: 'share',
            href: url
        }, function (response) {
        });
        console.log("Inside shareFacebook");
    }
    else {
        console.log("FB does not exist");
    }
}