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


    $('#avatar-input').change(function(){
        console.log("EYYY");
       $(this).closest('form').submit();
    });

    $('#change-banner-picture-label').click(function(){
        $('#banner-upload-input').click();
    });

    $('#change-profile-picture-label').click(function(){
        $('#avatar-upload-input').click();
    });

});