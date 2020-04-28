$(document).on("turbolinks:load", function(){

  $(function(){

        // コメント機能の非同期通信化
    function buildHTML(comment){
      var html = `<div class="comment">
      <div class="comment__left">
      <a href="/users/${comment.user_id}"><img class="comment__left--img" src="${comment.icon}">
      </a></div>
      <div class="comment__right">
      <div class="comment__right__upper">
      <div class="comment__right__upper--name">
      <a href="/users/${comment.user_id}">
      ${comment.user_name}
      </a></div>
      <div class="comment__right__upper--date">
      ${comment.date}
      </div>
      </div>
      <i class="fas fa-ellipsis-h deleteIcon"></i>
      <p></p>
      <a class="deleteBtn" rel="nofollow" data-method="delete" href="/posts/${comment.post_id}/comments/${comment.id}">コメントを削除する</a>
      <div class="comment__right__upper--text">
      <p>${comment.text}</p>
      </div>
      </div>
      </div>`
    return html
    }


    $("#new-comment").on('submit', function(e){
      e.preventDefault();
      var formData = new FormData(this);
      var url = $(this).attr('action');

      $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        var html = buildHTML(data);
        $('.CommentArea').append(html);
        $('#comment_text').val('');
        $('.submit__btn').prop('disabled', false);
      })
      .fail(function(){
        alert('コメント送信に失敗しました');
      })
    });

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
    })

  });
});