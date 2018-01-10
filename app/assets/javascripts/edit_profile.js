/**
 * Created by Peter on 7/16/17.
 */

function addGenre(){
   $('#genre_choices').append($('#new_genre_form').html())
}

function removeGenre(element) {
    element.parent().remove();
}

$(function() {
    if($.fn.cloudinary_fileupload !== undefined) {
        $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
    }
});
