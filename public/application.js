$(document).ready(function() {
  var pathname = window.location.pathname;
  var username = pathname.replace(/\//, '');

  params = {'username' : username};

  $.post('/check', params, function(tweetsStale){
      if (tweetsStale == 'true')
      {
        $('#loader').toggle();
        
        $.post('/fetch', params, function(tweets) {
          $('#container').html(tweets);
          $('#loader').toggle();
        });
      }
      else
      {
        $.post('/fetch', params, function(tweets) {
          $('#container').html(tweets);
        });
      }
  });

  $('#tweet_form').submit(function(e) {
    e.preventDefault();
    $('.input-field').prop('readonly', true);
    $('.message').html('Processing tweet...');

    var tweetText = $(this).serialize();

    $.ajax({
      type: this.method,
      url: this.action,
      data: tweetText
    }).done(function(response) {
      console.log(response);
      $('.message').html(response);
    });

  });

})


