/**
 * Created by Peter on 6/28/17.
 */


$(document).on('ready page: load', function() {
    var artist_name = $('#user_id_container').data('artist_name');
    if(artist_name != null){
        var $artist_name = $('#artist-name');
        $artist_name.val(artist_name.toUpperCase());
        $artist_name.css('border-bottom', 'none');
    }
});

function submitClaimArtist(){

    var email = $("#claim-email").val();
    var name = $("#artist-name").val();

    if(email != "" && name != ""){
        $.ajax({
            type: 'POST',
            url: '/claim_artist',
            data: {
                email: email,
                artist: name
            },
            success: function(){
                $('#claim_artist_modal_1').modal('hide');
                $('#claim_artist_modal_2').modal('show');
            }
        });
    }
}

function closeClaimArtist(){
    $('#claim_artist_modal_2').modal('hide');
}