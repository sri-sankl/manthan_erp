
//= require jquery
//= require jquery_ujs
//= require angular
//= require bootstrap
//= require_tree .

$(document).ready(function(ev){

  $('#custom_carousel').on('slide.bs.carousel', function (evt) {

      $('#custom_carousel .controls li.active').removeClass('active');
       $('#custom_carousel .controls li:eq('+$(evt.relatedTarget).index()+')').addClass('active');

   })

});
