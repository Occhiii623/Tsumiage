$(document).on("turbolinks:load", function(){

  $(function(){
    $('.profile__left__under--follow').hover(function(){
      $(this).css('background', '#fdebc1');
    }, function(){
      $(this).css('background', '');
    })
  })

});