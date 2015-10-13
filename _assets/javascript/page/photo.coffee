$ ->
  $grid_masonry = $('.grid').masonry({
    itemSelector: '.grid-item'
    precentPosition: true
    columnWidth: '.grid-sizer'
    transitionDuration: 0
  })

  $grid_masonry.imagesLoaded().progress((ins, image)->
    $img = $(image.img)
    img_height = $img.height()
    $img.parents("a").css("padding-bottom",$img.height())
    $img.parents("li").removeClass("is-loading")
    $grid_masonry.masonry('layout')
  )

  $("#links").on "click",(e)->
    links = $("#links").find("a")
    target = e.target
    link = if target.src then target.parentNode else target
    options = {index: link, event: e.originalEvent}
    blueimp.Gallery links,options
