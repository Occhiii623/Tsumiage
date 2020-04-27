$(function(){

  $(".deleteIcon").each(function(i){
    $(this).attr('id', 'item_' + (i+1));
  });

  $(".deleteBtn").each(function(i){
    $(this).attr('id', 'btn_' + (i+1));
  });

  $(".deleteIcon").each(function(i){

    i = i + 1
    $("#item_" + i).on('click', function(){
      $("#btn_" + i).toggle();
    })

  });
});