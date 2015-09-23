$(document).on('page:change', function() {
  $('[data-stream-thoughts]').each(function() {
    var $thoughtList = $(this);
    var scope = $thoughtList.data('scope');

    if(!$thoughtList.data('subscription')) {
      var subscription = consumer.subscriptions.create("ThoughtsChannel", {
        connected: function() {
          setTimeout(function() {
            this.perform('stream_thoughts', {
              scope: scope
            });
          }.bind(this), 500);
        },
        received: function(message) {
          if($thoughtList.find('[data-thought-id=' + message.thought_id + ']').length === 0) {
            $thoughtList.prepend(message.rendered_thought_partial);
          }
        }
      });

      $thoughtList.data('subscription', subscription);
    }
  });
});

$(document).on('page:before-change', function() {
  $('[data-stream-thoughts]').each(function() {
    var subscription = $(this).data('subscription');

    if(subscription) subscription.unsubscribe();
  });
});
