/**
 * Created by Peter on 6/8/17.
 */

$(document).on('ready page: load', function() {
    console.log("Running FB init script");
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '444853392519445',
            xfbml      : true,
            version    : 'v2.9'
        });
        FB.AppEvents.logPageView();
        console.log("FB Initialized");
    };
    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
});

function shareFacebook(url) {
    FB.ui({
        method: 'share',
        href: url
    }, function (response) {
    });
    console.log("Inside shareFacebook");
}