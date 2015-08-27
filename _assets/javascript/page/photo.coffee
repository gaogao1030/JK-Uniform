$ ->
  $grid_masonry = $('.grid').masonry({
    itemSelector: '.grid-item'
    precentPosition: true
    columnWidth: '.grid-sizer'
    transitionDuration: 0
  })

  $grid_masonry.imagesLoaded().progress ->
    $grid_masonry.masonry('layout')

