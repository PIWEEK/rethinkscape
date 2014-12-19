(function() {
  var textlider;

  textlider = function() {
    var item, items;
    items = $('.main-goal span');
    item = $('.main-goal span.active');
    if (items.last().hasClass('active')) {
      return item.fadeOut(500, function() {
        item.removeClass('active');
        items.first().addClass('active');
        return items.first().fadeIn('slow').css('display', 'block');
      });
    } else {
      return item.fadeOut(500, function() {
        item.removeClass('active');
        item.next().addClass('active');
        return item.next().fadeIn('slow').css('display', 'block');
      });
    }
  };

  setInterval(textlider, 2000);

}).call(this);
