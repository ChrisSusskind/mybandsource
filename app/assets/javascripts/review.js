/**
 * Created by Peter on 3/21/17.
 */

var user_id;
var show_responses = false;
var rating;

/*
Performs following actions when document is ready
1. Sets global variable equal to artist id or user id extracted from DOM element containing it as data
2. Adds click listener to window that hides dropdown menu when user clicks anywhere else on the screen
3. Adds click listeners to review/discussion toggle buttons
 */
$(document).on('turbolinks:load', function(){
    user_id = $('#user_id_container').attr('data-user_id');

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
        show_responses = false;
    });

    $('#discussion_button').on('click', function(e) {
        show_responses = true;
    });

});

$(document).on('page:change', function(){
    user_id = $('#user_id_container').attr('data-user_id');
});

/*
Function that is called when user selects dropdown option of ordering shown reviews by age (updated_at time) on artist page
Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
*/
function orderReviewsByAge(e) {
    e.preventDefault();
    reorderReviews(true);
}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by upvotes on artist page
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByUpvotes(e) {
    e.preventDefault();
    reorderReviews(false)
}

/*
Helper function called by orderReviewsBy() functions (above)
Submits ajax request to server to reorder reviews by age/upvote (depends on recent ordered) and specifies whether to show responses (discussion view) based on previous view
 */
function reorderReviews(recent_ordered) {
    $.ajax({
        method: 'GET',
        url: '/users/' + user_id + '/reviews/reorder/' + recent_ordered,
        data: {
            show_responses: show_responses
        }
    });
}

//Function that loads review form on artists page after "update review" button is clicked
function loadReviewForm(){
    $('#review_load_button').hide();
    $('#review_form').show();
    loadRatingEntry();
}

function submitReviewForm1(){
    var selected_rating = parseInt($('#rating_field').val());
    if(selected_rating != -1){
        rating = selected_rating;
        $('#review-form-1').hide();
        $('#review-form-2').show();

    }
}

function reviewFormGoBack(){
    $('#review-form-2').hide();
    $('#review-form-1').show();
}

//Function that sends an ajax request to server w/ content to create a new review
function createReview() {
    var comment = $('#review-form-text').val();

    if(comment != ""){
        $.ajax({
            type: 'POST',
            url: '/users/' + user_id + '/reviews',
            data: {
                rating: rating,
                comment: comment
            }
        });
    }
}

//Function that sends an ajax request to server w/ content to update an existing review
function updateReview(review_id) {
    var comment = $('#review-form-text').val();

    $.ajax({
        type: 'PUT',
        url: '/users/' + user_id + '/reviews/' + review_id,
        data: {
            rating: rating,
            comment: comment
        }
    });
}

/*
Function that creates a response creation form when reply button is clicked
Submit action of this form is to send an ajax request to server w/ content to create a new response
 */
function showReplyForm(node) {
    var review_text_container = node.parentElement.parentElement.parentElement;
    var review = review_text_container.parentElement;
    var review_id = review.getAttribute('data-review_id');
    var profile_pic_url = $('#user_id_container').data('user_picture_url');
    var current_user_profile_url = $('#user_id_container').data('current_user');
    if(current_user_profile_url < 3){
        current_user_profile_url = "http://res.cloudinary.com/mybandsource/image/upload/v1490846366/static/blank_user.png";
    }
    var wrapper = document.createElement('div');
    wrapper.innerHTML = '' +
        '<div class="reply-form-container">' +
            '<div class="inner-profile-response" style="background: url(\''+ current_user_profile_url +'\');-webkit-background-size: cover;-moz-background-size: cover;-o-background-size: cover;background-size: cover;background-position: center center;">' +
                '<img src="'+ current_user_profile_url +'" style="width:36px;height:36px;visibility: hidden;"/>' +
            '</div>'+

            '<div class="text-container">' +
                '<form id="reply_form" class="reply-form mx-auto">' +
                '   <textarea id="reply"></textarea>' +
                '   <input class="btn btn-danger reply-form-btn" type="submit" value="Submit">' +
                '</form>' +
            '</div>' +
        '</div>';
    review_text_container.append(wrapper);
    $('#reply_form').submit(function (e) {
        e.preventDefault();
        var $reply = $('#reply');
        if($reply.val() != ""){
            $.ajax({
                type: 'POST',
                url: '/users/' + user_id + '/reviews/' + review_id + '/responses',
                data: {
                    comment: $reply.val()
                },
                dataType: 'script'
            })
        }
    });
    node.onclick = null;
}