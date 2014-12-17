textlider = ->
    items = $('.main-goal span')
    item = $('.main-goal span.active')

    if items.last().hasClass('active')
        item.fadeOut(500, ->
            item.removeClass('active')
            items.first().addClass('active')
            items.first().fadeIn('slow').css('display','block');
        )
    else
        item.fadeOut(500, ->
            item.removeClass('active')
            item.next().addClass('active')
            item.next().fadeIn('slow').css('display','block');
        )

setInterval(textlider, 2000)
