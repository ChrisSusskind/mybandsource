/**
 * Created by Peter on 3/20/17.
 */

var stars;
var selected_rating;
var ratings_list = [];

/*
Initializes stars array to contain the 5 DOM elements for the 5 stars and sets event handlers for mouseenter (temporarily shade star), mouseleave (remove temporary shade), and click (shade star until another rating is selected by clicking a different star)
Displays stars correctly filled in to represent rating if one has previously been made (and we are in update rating view)
Calls loadRatings() to fill in all stars for reviews in review list displayed for profile
 */
$(document).ready(function(){
    var temp = $('#leave_rating');
    stars = temp.find('span');
    selected_rating = parseInt($('#rating_field').val());
    if(selected_rating != -1){
        loadRatingToUpdate(selected_rating);
    }
    for(var i=0; i<stars.length; i++){
        stars[i].setAttribute('data_count', i);
        stars[i].addEventListener('mouseenter', fillStars);
        stars[i].addEventListener('mouseleave', emptyStars);
        stars[i].addEventListener('click', onClick);
    }
    loadRatings();
});

//Function that adds hover class to stars when they should be shown full
function fillStars(e){
    for (var i=0; i < stars.length; i++){
        if(stars[i].getAttribute('data_count') <= e.target.getAttribute('data_count')){
            stars[i].classList.add('hover');
        }
    }
    console.log(e.target);
}

//Function that removes hover class from stars when they should be shown empty
function emptyStars(e){
    for (var i=0; i < stars.length; i++){
            if(stars[i].getAttribute('data_count') > selected_rating-1){
            stars[i].classList.remove('hover');
        }
    }
    console.log(e.target);
}

/*
Function called when a star is clicked on (i.e. a rating is being made)
Calls emptyStars() and fillStars() to change star display to match chosen rating
 */
function onClick(e){
    selected_rating = parseInt(e.target.getAttribute('data_count'))+1;
    $('#rating_field').val(selected_rating);
    emptyStars(e);
    fillStars(e);
}

//Function used to add hover class to fill in stars for previous rating made by user (when update review view is shown)
function loadRatingToUpdate(rating){
    for(var i=0; i < rating; i++){
        stars[i].classList.add('hover');
    }
}

//Function used to fill stars for each displayed review in a list of displayed reviews
function loadRatings(){
    $(".ratings_list").each(function(){
        ratings_list.push({rating: this.getAttribute('data-rating'), children: $(this).find('span')});
    });


    for(var i=0; i<ratings_list.length; i++){
        for(var j=0; j < ratings_list[i].rating; j++){
            console.log(j);
            ratings_list[i].children[j].classList.add('hover');
        }
    }
}