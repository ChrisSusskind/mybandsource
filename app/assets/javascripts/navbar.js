/**
 * Created by Peter on 6/8/17.
 */

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