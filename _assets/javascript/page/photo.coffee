$ ->
  $grid_masonry = $('.grid').masonry({
    itemSelector: '.grid-item'
    precentPosition: true
    columnWidth: '.grid-sizer'
  })

  $grid_masonry.imagesLoaded().progress ->
    $grid_masonry.masonry('layout')

