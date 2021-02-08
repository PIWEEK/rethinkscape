(function() {
  var images, isScrolledIntoView, isVisible, textlider;

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

  isVisible = function() {
    $.each(images, function(index, value) {
      var visibility;
      visibility = isScrolledIntoView(value);
      if (visibility) {
        $(this).addClass("display");
      }
    });
  };

  isScrolledIntoView = function(elem) {
    var docViewBottom, docViewTop, elemBottom, elemTop;
    docViewTop = $(window).scrollTop();
    docViewBottom = docViewTop + $(window).height();
    elemTop = $(elem).offset().top;
    elemBottom = elemTop + $(elem).height();
    return (elemBottom <= docViewBottom) && (elemTop >= docViewTop);
  };

  images = $("img");

  $(window).on("scroll", function() {
    isVisible();
  });

}).call(this);
