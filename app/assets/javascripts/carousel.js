/**
 * Created by Peter on 6/8/17.
 */

$(document).on('turbolinks:load', function() {
    $('.artist-carousel').slick({
        infinite: true,
        autoplay: true,
        autoplaySpeed: 5000,
        speed: 500,
        arrows: true,
        slidesToShow: 4,
        slidesToScroll: 1,
        variableWidth: true,
        prevArrow: '<img class="prev-arrow" src="http://res.cloudinary.com/mybandsource/image/upload/v1498680955/static/prev_arrow.png" />',
        nextArrow: '<img class="next-arrow" src="http://res.cloudinary.com/mybandsource/image/upload/v1498680955/static/next_arrow.png" />',
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1
                }
            }
            // You can unslick at a given breakpoint now by adding:
            // settings: "unslick"
            // instead of a settings object
        ]
    });
});