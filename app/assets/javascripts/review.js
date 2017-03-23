/**
 * Created by Peter on 3/21/17.
 */

var artist_id;

/*
Performs following actions when document is ready
1. Sets global variable equal to artist id extracted from DOM element containing it as data
2. Adds click listener to window that hides dropdown menu when user clicks anywhere else on the screen
 */
$(document).ready(function(){
    var artist_id_container = $('.artist_id_container');
    artist_id = artist_id_container.attr('data-artist_id');

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
});

//Function that
$(function() {
    $(document.body).off('click', 'nav.pagination a');
    $(document.body).on('click', 'nav.pagination a', function(e) {
        e.preventDefault();
        var loadingHTML = "<div class='loading'>Loading...</div>";
        $("#reviews_container").html(loadingHTML).load($(this).attr("href"), function(){
            loadRatingsStyle();
            changeTimeDisplays();
        });
        return false;
    });
});

//Function that is called when dropdown menu button is clicked on (toggles whether options are shown)
function toggleDropdown() {
    document.getElementById('reviews_dropdown').classList.toggle("show");
}

/*
Function that is called when user selects dropdown option of ordering shown reviews by age (created_at time)
Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
*/
function orderReviewsByAge(e) {
    e.preventDefault();
    $('.reviews_container').empty();
    reorderReviews(true);
}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by upvotes
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByUpvotes(e) {
    e.preventDefault();
    age_ordered = false;
    $('.reviews_container').empty();
    reorderReviews(false)
}

function reorderReviews(recent_ordered) {
    $.ajax({
        method: 'GET',
        url: '/artists/' + artist_id + '/reviews/reorder/' + recent_ordered,
        success: function(){
            loadRatingsStyle();
            changeTimeDisplays();
        }
});
}

function loadReviewForm(){
    $('#review_load_button').hide();
    $('#review_form').show();
}