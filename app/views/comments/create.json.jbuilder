json.text       @comment.text
json.user_id    @comment.user.id
json.user_name  @comment.user.nickname
json.icon       @comment.user.icon.url
json.date       @comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.post_id    @comment.post.id
json.id         @comment.id