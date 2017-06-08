/**
 * Created by Peter on 3/20/17.
 */

var stars;
var selected_rating;

/*
 Performs following actions when document is ready
 1. Loads info and style for already entered review (if being given option to update)
 2. Loads style for ratings list being displayed
 3. Changes timestamp displayed for rating to english representation
 */
$(document).on('ready page:load', function(){

});

//Function that adds hover class to stars when they should be shown full
function fillStars(e){
    for (var i=0; i < stars.length; i++){
        if(stars[i].getAttribute('data_count') <= e.target.getAttribute('data_count')){
            stars[i].classList.add('hover');
        }
    }
}

//Function that removes hover class from stars when they should be shown empty
function emptyStars(e){
    for (var i=0; i < stars.length; i++){
            if(stars[i].getAttribute('data_count') > selected_rating-1){
            stars[i].classList.remove('hover');
        }
    }
}

/*
Function called when a star is clicked on (i.e. a rating is being made)
Calls emptyStars() and fillStars() to change star display to match chosen rating
 */
function onStarClick(e){
    selected_rating = parseInt(e.target.getAttribute('data_count'))+1;
    $('#rating_field').val(selected_rating);
    emptyStars(e);
    fillStars(e);
}

//Function used to get previously entered rating info and to add styling to that rating (from create/update review form)
function loadRatingEntry(){
    var temp = $('#leave_rating');
    stars = temp.find('span');
    selected_rating = parseInt($('#rating_field').val());

    for(var i=0; i<stars.length; i++){
        stars[i].setAttribute('data_count', i);
        stars[i].addEventListener('mouseenter', fillStars);
        stars[i].addEventListener('mouseleave', emptyStars);
        stars[i].addEventListener('click', onStarClick);
    }

    for(var j=0; j < selected_rating; j++){
        stars[j].classList.add('hover');
    }
}