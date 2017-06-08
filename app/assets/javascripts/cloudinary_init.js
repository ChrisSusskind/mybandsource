/**
 * Created by Peter on 6/8/17.
 */

$(document).on('ready page: load', function() {
    if($.fn.cloudinary_fileupload !== undefined) {
        $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
    }
});