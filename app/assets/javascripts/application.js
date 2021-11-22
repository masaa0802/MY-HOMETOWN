// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
// require jquery

//= require activestorage
//= require turbolinks
//= require_tree .

/* global $ */

$(document).ready(function(){
// オプションを指定してSkipprの実行
$(".theTarget").skippr({
  // スライドショーの変化（"fade" or "slide"）
  transition : 'fade',
  // 変化にかかる時間（ミリ秒）
  speed : 1000,
  // easingの種類
  easing : 'easeOutQuart',
  // ナビゲーションの形（"block" or "bubble"）
  navType : 'block',
  // 子要素の種類（"div" or "img"）
  childrenElementType : 'div',
  // ナビゲーション矢印の表示（trueで表示）
  arrows : true,
  // スライドショーの自動再生（falseで自動再生なし）
  autoPlay : false,
  // 自動再生時のスライド切替間隔（ミリ秒）
  autoPlayDuration : 5000,
  // キーボードの矢印キーによるスライド送りの設定（trueで有効）
  keyboardOnAlways : true,
  // 1枚目のスライド表示時に戻る矢印を表示するかどうか [false]:矢印を隠さない [true]:矢印を隠す
  hidePrevious : false
});

});
// コメント投稿エリア表示
$(function () {
  $(document).on("click", ".comment-button", function () {
    const commentId = $(this).data('comment-id');
    console.log(commentId);
    $('#js-textarea-post-' + commentId).show();
    $('#js-comment-label-' + commentId).hide();
    $('#js-comment-button-' + commentId).show();
  });
  $(document).on("click", ".comment-cancel-button", function () {
    const commentId = $(this).data('cancel-id');
    $('#js-textarea-post-' + commentId).hide();
    $('#js-comment-label-' + commentId).show();
    $('#js-comment-button-' + commentId).hide();
  });
});


// コメント編集エリア表示
$(function () {
  $(document).on("click", ".edit-comment-button", function () {
    const commentId = $(this).data('comment-id');
    console.log(commentId);
    $('#js-textarea-' + commentId).show();
    $('#js-comment-label-' + commentId).hide();
    $('#js-textarea-comment-' + commentId).show();
    $('#js-comment-button-' + commentId).show();
  });
  $(document).on("click", ".comment-cancel-button", function () {
    const commentId = $(this).data('cancel-id');
    $('#js-comment-label-' + commentId).show();
    $('#js-textarea-comment-' + commentId).hide();
    $('#js-comment-button-' + commentId).hide();
    $('#js-comment-post-error-' + commentId).hide();
  });

  // コメント更新ボタン
  $(document).on("click", ".comment-update-button", function () {
    const commentId = $(this).data('update-id');
    const textField = $('#js-textarea-comment-' + commentId);
    const body = textField.val();

    $.ajax({
      url: `/post/${postId}/comments/${commentId}`,
      type: 'PATCH',
      data: {
        comment: {
          body: body
        }
      }
    }).done(function (date) {  // ajax通信が成功した時の処理
      $('#js-comment-label-' + commentId).show();
      $('#js-textarea-comment-' + commentId).hide().text(data.body);
      $('#js-comment-button-' + commentId).hide();
      $('#js-comment-post-error-' + commentId).hide();
    }).fail(function () {
      const commentError = $('#js-comment-post-error-' + commentId);
      commentError.text('コメントを入力してください');
    })

  });
});
