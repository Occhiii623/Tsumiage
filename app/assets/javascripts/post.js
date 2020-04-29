$(document).on("turbolinks:load", function(){
  $(function(){

  $('.bootstrap-tagsinput input').blur(function(){jQuery(this).attr('placeholder', '')})

});
});