$(document).on("turbolinks:load", function(){

  function addTag(tag){
    let html = `<a class="search-result" href="/tags/${tag.id}">
                <div class="search-result__tag-name">
                  ${tag.name}
                </div>
                <div class="search-result__tag-count">
                <p>(${tag.count})</p>
                </div>
                </a>`;
    $('#result').append(html);
  }

  function addNoTag(){
    let html = `<div class="search-noresult">
                <div class="search-noresult__tag-name">
                該当するタグが見つかりません
                </div></div>
                `;
    $('#result').append(html);
  }

  $(function(){
    $('#keyword').on('keyup', function(e){
      e.preventDefault();
      let input = $('#keyword').val();
      
      $.ajax({
        type: 'GET',
        url: '/tags',
        dataType: 'json',
        data: { keyword: input }
      })
      .done(function(tags){
        $('#result').empty();
        if (tags.length !== 0) {
          tags.forEach(function(tag){
            addTag(tag);
          });
        } else if (input.length == 0) {
          return false;
        } else {
          addNoTag();
        }
      })
      .fail(function(){
        alert("通信エラーです。検索結果を表示できません。");
      })
    })
  })




});