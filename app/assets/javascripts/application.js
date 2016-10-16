//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require_tree

$(document).ready(function() {

  $(".slide-section").click(function(e){

      var linkHref = $(this).attr("href");

      $("html, body").animate({
        scrollTop : $(linkHref).offset().top
      }, 1000);

      e.preventDefault();
    });


});
