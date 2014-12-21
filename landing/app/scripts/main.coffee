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

isVisible = ->
  $.each images, (index, value) ->
    visibility = isScrolledIntoView(value)
    $(this).addClass "display"  if visibility
    return

  return
isScrolledIntoView = (elem) ->
  docViewTop = $(window).scrollTop()
  docViewBottom = docViewTop + $(window).height()
  elemTop = $(elem).offset().top
  elemBottom = elemTop + $(elem).height()
  (elemBottom <= docViewBottom) and (elemTop >= docViewTop)
images = $("img")
$(window).on "scroll", ->
  isVisible()
  return
