/**
 * Created by Peter on 6/8/17.
 */

$(document).on('turbolinks:load', function() {

    $('.profile-picture-overlay').hover(function(){
        $(".change-profile-pic-text").css("opacity", 1);
    }, function(){
        $(".change-profile-pic-text").css("opacity", 0);
    });

    $('.header-picture-overlay').hover(function(){
        $(".change-header-pic-text").css("opacity", 1);
    }, function(){
        $(".change-header-pic-text").css("opacity", 0);
    });

});