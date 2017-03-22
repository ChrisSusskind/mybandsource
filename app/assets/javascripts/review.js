/**
 * Created by Peter on 3/21/17.
 */

const step = 10;
var age_ordered = true;
var number_displayed;
var max_reviews;

$(document).ready(function(){
    changeTimeDisplays();
});

$(document).ready(function(){
    var artist_id_container = $('.artist_id_container');
    var artist_id = artist_id_container.attr('data-artist_id');
    number_displayed = $('.reviews_container').children().length;
    $.ajax({
        type: 'GET',
        url: '/artists/' + artist_id + '/review_number',
        dataType: "json",
        success: function(result){
            max_reviews = result.number_of_reviews;
        }
    });

    $('.show_more_reviews').click(function(e){
       e.preventDefault();
       show_more_reviews(number_displayed)
   }) ;

   $('.show_all_reviews').click(function(e){
       e.preventDefault();
       show_all_reviews(number_displayed)
   });
});

window.onclick = function(e){
  if(!e.target.matches('.dropbtn')){
      var dropdowns = $('.dropdown-content');
      for(var i=0; i<dropdowns.length ;i++){
          if(dropdowns[i].classList.contains('show')){
              dropdowns[i].classList.remove('show');
          }
      }
  }
};

function changeTimeDisplays(){
    $('abbr.timeago').timeago();
}

function toggleDropdown() {
    document.getElementById('reviews_dropdown').classList.toggle("show");
}

function orderReviewsByAge(e) {
    e.preventDefault();
    age_ordered = true;
    $('.reviews_container').empty();
    show_more_reviews(-1);

}

function orderReviewsByUpvotes(e) {
    e.preventDefault();
    age_ordered = false;
    $('.reviews_container').empty();
    show_more_reviews(-1);
}

function show_more_reviews(num_displayed) {
    var artist_id_container = $('.artist_id_container');
    var artist_id = artist_id_container.attr('data-artist_id');
    $.ajax({
        type: 'GET',
        url: '/artists/' + artist_id + '/more_reviews/' + num_displayed,
        data: {recent_order: age_ordered},
        dataType: "script"
    }).done(function(){
        loadRatings();
        changeTimeDisplays();
        number_displayed+=step;
        if(number_displayed >= max_reviews){
            hideButtons();
        }
    });
}

function show_all_reviews(num_displayed) {
    var artist_id_container = $('.artist_id_container');
    var review_id = artist_id_container.attr('data-review_id');
    var artist_id = artist_id_container.attr('data-artist_id');
    $.ajax({
        type: 'GET',
        url: '/artists/' + artist_id + '/all_reviews/' + num_displayed,
        data: {recent_order: age_ordered},
        dataType: "script"
    }).done(function(){
        loadRatings();
        changeTimeDisplays();
        number_displayed+=step;
        if(number_displayed >= max_reviews){
            hideButtons();
        }
    });
}

function hideButtons(){
    $('.show_more_reviews').hide();
    $('.show_all_reviews').hide();
}