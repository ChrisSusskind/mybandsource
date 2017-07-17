/**
 * Created by Peter on 6/8/17.
 */

$(document).on('turbolinks:load', function() {
  // Give live search results a height of 200px when something is entered in id search-box or id search-bar
});

function displaySearch(){
    $('.navbar-links').hide();
    $('.navbar-header').hide();
    $('.navbar-search-container').show();
    $('.close').show();
}

function hideSearch(){
    $('.navbar-search-container').hide();
    $('.close').hide();
    $('.navbar-links').show();
    $('.navbar-header').show();
}