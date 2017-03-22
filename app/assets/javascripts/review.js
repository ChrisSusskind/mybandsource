/**
 * Created by Peter on 3/21/17.
 */

const step = 10;
var age_ordered = true;
var number_displayed;
var max_reviews;

//Calls a helper function that changes timestamps to english when page first loads
$(document).ready(function(){
    changeTimeDisplays();
});

/*
Submits Ajax request to get number of reviews for artist (used to decide when to hide buttons)
Sets onclick event handlers for 2 buttons that use helper functions to show more reviews (shows another 'step' [currently 10] reviews) and show all reviews
 */
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

//Hides dropdown menu when user clicks anywhere else on the screen
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

//Function that changes timestamps to english for display
function changeTimeDisplays(){
    $('abbr.timeago').timeago();
}

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
    age_ordered = true;
    $('.reviews_container').empty();
    show_more_reviews(-1);

}

/*
 Function that is called when user selects dropdown option of ordering shown reviews by upvotes
 Removes all reviews currently shown on the screen and reloads 10 initial ones using helper function show_more_reviews()
 */
function orderReviewsByUpvotes(e) {
    e.preventDefault();
    age_ordered = false;
    $('.reviews_container').empty();
    show_more_reviews(-1);
}

/*
Function that submits ajax request to display step (currently 10) more reviews (or as many as possible if there are <10 non-displayed associated reviews)
Rails app responds by appending a partial that shows new reviews to the already displayed review list
After ajax request completes the function calls other functions to load star displays/change time display, increments global variable for number of reviews displayed, and hides show more/all review buttons if necessary
 */
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

/*
 Function that submits ajax request to add to display all associated reviews currently not shown
 Rails app responds by appending a partial that shows new reviews to the already displayed review list
 After ajax request completes the function calls other functions to load star displays/change time display, increments global variable for number of reviews displayed, and hides show more/all review buttons if necessary
 */
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

//Function that hids show more reviews/show all reviews buttons (called when all associated reviews are currently being displayed)
function hideButtons(){
    $('.show_more_reviews').hide();
    $('.show_all_reviews').hide();
}