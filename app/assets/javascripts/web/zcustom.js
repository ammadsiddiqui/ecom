jQuery(document).ready(function () {
    jQuery(document).click(function (event) {
        var clickover = jQuery(event.target);
        var _opened = jQuery(".navbar-collapse").hasClass("show");
        if (_opened === true && !clickover.hasClass("navbar-toggler")) {
            jQuery(".navbar-toggler").click();
        }
    });
}); 

jQuery('.home-slider').slick({
    dots: true,
    infinite: true,
    speed: 300,
    slidesToShow: 1,
});

jQuery('.home-slider1').slick({
    dots: true,
    infinite: true,
    autoplay: true,
    arrows : false,
    speed: 300,
    slidesToShow: 3,
});
