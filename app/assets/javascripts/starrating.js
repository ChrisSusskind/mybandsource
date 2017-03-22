/**
 * Created by Peter on 3/20/17.
 */

var stars;
var selected_rating;
var ratings_list = [];

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

function fillStars(e){
    for (var i=0; i < stars.length; i++){
        if(stars[i].getAttribute('data_count') <= e.target.getAttribute('data_count')){
            stars[i].classList.add('hover');
        }
    }
    console.log(e.target);
}

function emptyStars(e){
    for (var i=0; i < stars.length; i++){
            if(stars[i].getAttribute('data_count') > selected_rating-1){
            stars[i].classList.remove('hover');
        }
    }
    console.log(e.target);
}

function onClick(e){
    selected_rating = parseInt(e.target.getAttribute('data_count'))+1;
    $('#rating_field').val(selected_rating);
    emptyStars(e);
    fillStars(e);
}

function loadRatingToUpdate(rating){
    for(var i=0; i < rating; i++){
        stars[i].classList.add('hover');
    }
}

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