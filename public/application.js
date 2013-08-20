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
        console.log('these are freeessh tweets')
        $.post('/fetch', params, function(tweets) {
          $('#container').html(tweets);
        });
      }
  });

})


