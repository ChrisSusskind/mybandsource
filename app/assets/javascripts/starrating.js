/**
 * Created by Peter on 3/20/17.
 */

var stars;
var selected_rating;
var ratings_list = [];

/*
 Performs following actions when document is ready
 1. Loads style for ratings list being displayed
 2. Changes timestamp displayed for rating to english representation
 3. Loads style for already entered review (if being given option to update)
 4. Adds star id (data_count), mouseenter, mouseleave, and click handler events for stars (used to change style when rating is being entered)
 */
$(document).ready(function(){
    loadRatingsStyle();

    changeTimeDisplays();

    var temp = $('#leave_rating');
    stars = temp.find('span');
    selected_rating = parseInt($('#rating_field').val());
    if(selected_rating != -1){
        loadRatingEntryStyling(selected_rating);
    }

    for(var i=0; i<stars.length; i++){
        stars[i].setAttribute('data_count', i);
        stars[i].addEventListener('mouseenter', fillStars);
        stars[i].addEventListener('mouseleave', emptyStars);
        stars[i].addEventListener('click', onStarClick);
    }
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

//Function used to add hover class to fill in stars for previous rating made by user (when update review view is shown)
function loadRatingEntryStyling(rating){
    for(var i=0; i < rating; i++){
        stars[i].classList.add('hover');
    }
}

//Function that changes timestamps to english for display
function changeTimeDisplays(){
    $('abbr.timeago').timeago();
}

//Function used to fill stars for each displayed review in a list of displayed reviews
function loadRatingsStyle(){
    $(".ratings_list").each(function(){
        ratings_list.push({rating: this.getAttribute('data-rating'), children: $(this).find('span')});
    });


    for(var i=0; i<ratings_list.length; i++){
        for(var j=0; j < ratings_list[i].rating; j++){
            ratings_list[i].children[j].classList.add('hover');
        }
    }
}