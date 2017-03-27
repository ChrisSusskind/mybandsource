/**
 * Created by Peter on 3/21/17.
 */

var artist_id;
var show_responses = false;

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

    $('#reviews_button').on('click', function(e) {
        console.log("Review button clicked");
        show_responses = false;
    });

    $('#discussion_button').on('click', function(e) {
        console.log("Discussion button clicked");
        show_responses = true;
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
    //$('.reviews_container').empty();
    reorderReviews(true);
}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by upvotes
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByUpvotes(e) {
    e.preventDefault();
    age_ordered = false;
    //$('.reviews_container').empty();
    reorderReviews(false)
}

function reorderReviews(recent_ordered) {
    $.ajax({
        method: 'GET',
        url: '/artists/' + artist_id + '/reviews/reorder/' + recent_ordered,
        data: {
          show_responses: show_responses
        },
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

function showReplyForm(node){
    var review = node.parentElement.parentElement.parentElement;
    var review_id = review.getAttribute('data-review_id');
    var wrapper = document.createElement('div');
    wrapper.innerHTML = '<form id="reply_form"><textarea id="reply"></textarea><input type="submit" value="Submit"></form>';
    review.append(wrapper);
    $('#reply_form').submit(function(e){
       e.preventDefault();
       $.ajax({
           type: 'POST',
           url: '/artists/' + artist_id + '/reviews/' + review_id + '/responses',
           data: {
               comment: $('#reply').val()
           },
           dataType: 'script'
       })
    });
}

function getReviewOrder(){
    return show_responses;
}