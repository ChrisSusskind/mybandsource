/**
 * Created by Peter on 3/21/17.
 */

var artist_id;
var user_id;
var show_responses = false;

/*
Performs following actions when document is ready
1. Sets global variable equal to artist id or user id extracted from DOM element containing it as data
2. Adds click listener to window that hides dropdown menu when user clicks anywhere else on the screen
3. Adds click listeners to review/discussion toggle buttons
 */
$(document).on('turbolinks:load', function(){
    artist_id = $('#artist_id_container').attr('data-artist_id');
    user_id = $('#user_id_container').attr('data-user_id');
    console.log(artist_id);
    console.log(user_id);

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
Function that is called when user selects dropdown option of ordering shown reviews by age (updated_at time) on artist page
Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
*/
function orderReviewsByAge(e) {
    e.preventDefault();
    reorderReviews(true, true);
}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by upvotes on artist page
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByUpvotes(e) {
    e.preventDefault();
    reorderReviews(false, true)
}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by age (updated_at time) on user page
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByAgeUserProfile(e){
    e.preventDefault();
    reorderReviews(true, false)
}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by upvotes on user page
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByUpvotesUserProfile(e){
    e.preventDefault();
    reorderReviews(false, false)
}

/*
Helper function called by orderReviewsBy() functions (above)
Submits ajax request to server to reorder reviews by age/upvote (depends on recent ordered) and specifies whether to show responses (discussion view) based on previous view
 */
function reorderReviews(recent_ordered, artist_profile) {
    if(artist_profile){
        $.ajax({
            method: 'GET',
            url: '/artists/' + artist_id + '/reviews/reorder/' + recent_ordered,
            data: {
                show_responses: show_responses
            }
        });
    }
    else{
        $.ajax({
            method: 'GET',
            url: '/users/' + user_id + '/reviews/reorder/' + recent_ordered,
            data: {
                show_responses: show_responses
            }
        });
    }
}

//Function that loads review form on artists page after "update review" button is clicked
function loadReviewForm(){
    $('#review_load_button').hide();
    $('#review_form').show();
}

/*
Function that creates a response creation form when reply button is clicked
Submit action of this form is to send an ajax request to server w/ content to create a new response
 */
function showReplyForm(node) {
    var review = node.parentElement.parentElement.parentElement;
    var review_id = review.getAttribute('data-review_id');
    var wrapper = document.createElement('div');
    wrapper.innerHTML = '<form id="reply_form"><textarea id="reply"></textarea><input type="submit" value="Submit"></form>';
    review.append(wrapper);
    var user_profile = (artist_id == null);
    $('#reply_form').submit(function (e) {
        e.preventDefault();
        $.ajax({
            type: 'POST',
            url: '/artists/' + artist_id + '/reviews/' + review_id + '/responses',
            data: {
                comment: $('#reply').val(),
                user_profile: user_profile
            },
            dataType: 'script'
        })
    });
    node.onclick = null;
}

//Function that returns show_responses global variable that identifies whether current view is reviews (no comments) or discussion (comments shown)
function isDiscussionView(){
    return show_responses;
}