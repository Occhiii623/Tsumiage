$(document).on("turbolinks:load", function(){

  $(function(){
    $('.following-now').hover(function(){
      $(this).css('background', '#DD0000');
      $(this).css('border-color', '#DD0000');
      $(this).val('フォロー解除');
    }, function(){
      $(this).css('background', '');
      $(this).css('border-color', '');
      $(this).val('フォローしています');
    })
  })

});